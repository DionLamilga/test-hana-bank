// 
//  DashboardView.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import UIKit
import RxSwift
import RxCocoa

class DashboardView: BaseViewController {
    
    @IBOutlet weak var pokemonSearch: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardTable: UITableView!
    
    var presenter: DashboardPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension DashboardView {
    func setup() {
        initService()
        setupView()
        setupTable(cardTable)
    }
    
    func setupView() {
        titleLabel.text = "Pokemon TGC"
        pokemonSearch.placeholder = "Search Pokemon"
    }
    
    func initService() {
        presenter?.getDataPokemeon(on: self, page: presenter?.page ?? 0)
    }
}

extension DashboardView {
    func setupTable(_ tableView: UITableView) {
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(CardCell.nib(), forCellReuseIdentifier: CardCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        tableView.tableFooterView = spinner
        
        let searchTerm = pokemonSearch.rx.text.orEmpty
            .distinctUntilChanged()
        
        Observable.combineLatest(presenter?.pokemonList ?? BehaviorRelay<[PokemonCard]>(value: []), searchTerm)
            .map {self.filter(data: $0.0, filter: $0.1)}
            .bind(to: tableView.rx.items(cellIdentifier: CardCell.identifier,
                                         cellType: CardCell.self)) { _, item, cell in
                if item.isSkeleton {
                    cell.showSkeleton()
                } else {
                    cell.hideSkeleton()
                    cell.setupCell(data: item)
                }
            } .disposed(by: bag)
        
        tableView.rx.modelSelected(PokemonCard.self)
            .subscribe(onNext: {[weak self] item in
                guard let self else {return}
                //GET DETAIL FROM SELECTED CARD
                self.presenter?.navigateToDetail(from: self.navigationController ?? UINavigationController(), pokemonDetail: item)
                
                //GET DETAIL FROM SERVICE
                //self.presenter?.getDetailCard(on: self, cardId: item.id ?? "")
            }).disposed(by: bag)
        
        tableView.rx.contentOffset
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] offset in
                guard let self = self,
                      let presenter = self.presenter,
                      !presenter.isLoading,
                      presenter.hasMoreData else { return }

                let contentHeight = tableView.contentSize.height
                let tableViewHeight = tableView.frame.size.height
                let offsetY = offset.y

                if offsetY + tableViewHeight + 100 > contentHeight {
                    spinner.startAnimating()

                    presenter.getDataPokemeon(on: self, page: presenter.page) {
                        DispatchQueue.main.async {
                            spinner.stopAnimating()
                        }
                    }
                }
            }).disposed(by: bag)
    }
    
    func filter(data: [PokemonCard], filter: String) -> [PokemonCard] {
        var dataPokemon = [PokemonCard]()
        if !filter.isEmpty {
            dataPokemon = data.filter {
                $0.name?.range(of: filter, options: .caseInsensitive) != nil ||
                $0.evolvesFrom?.range(of: filter, options: .caseInsensitive) != nil ||
                $0.types?.contains(where: { $0.range(of: filter, options: .caseInsensitive) != nil }) == true
            }
        } else {
            dataPokemon = data
        }
        return dataPokemon
    }
}
