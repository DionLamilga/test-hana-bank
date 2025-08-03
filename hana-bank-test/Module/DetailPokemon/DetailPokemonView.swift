// 
//  DetailPokemonView.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class DetailPokemonView: BaseViewController {
    
    @IBOutlet weak var header: Header!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var weaknessLabel: UILabel!
    @IBOutlet weak var resistanceLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var lavelLabel: UILabel!
    
    var presenter: DetailPokemonPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setup()
    }
}

extension DetailPokemonView {
    func setup() {
        setupView()
        setupAction()
    }
    
    func setupView() {
        header.titleLabel.text = presenter?.pokemonDetail?.name
        cardImage.kf.setImage(with: URL(string: presenter?.pokemonDetail?.images?.large ?? ""))
        hpLabel.text = "HP: \(presenter?.pokemonDetail?.hp ?? "-")"
        lavelLabel.text = "Level: \(presenter?.pokemonDetail?.level ?? "-")"
        weaknessLabel.text = presenter?.pokemonDetail?.weaknesses?.first?.type ?? "-"
        resistanceLabel.text = presenter?.pokemonDetail?.resistances?.first?.type ?? "-"
    }
    
    func setupAction() {
        header.backButton.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self,
                  let presenter = self.presenter,
                  let navigationController = self.navigationController else { return }
            presenter.backtoPreviousPage(from: navigationController)
        }).disposed(by: bag)
    }
}
