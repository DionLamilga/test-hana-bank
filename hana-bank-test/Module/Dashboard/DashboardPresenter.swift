// 
//  DashboardPresenter.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import UIKit
import RxSwift
import RxCocoa

class DashboardPresenter: BasePresenter {
    
    private let interactor: DashboardInteractor
    private let router = DashboardRouter()
    
    var pokemonList = BehaviorRelay<[PokemonCard]>(value: [])
    var pokemonCardDetail = PublishSubject<DetailPokemonCardResponse>()
    var page: Int = 1
    var isLoading: Bool = false
    var hasMoreData: Bool = true
    let skeletonList: [PokemonCard] = Array.init(repeating: .init(), count: 3)
    
    init(interactor: DashboardInteractor) {
        self.interactor = interactor
    }
    
    //MARK: - Service Handler
    func getDataPokemeon(on view: UIViewController, page: Int, completion: (() -> Void)? = nil) {
        guard !isLoading, hasMoreData else {
            completion?()
            return
        }
        
        isLoading = true
        if page == 1 {
            pokemonList.accept(skeletonList)
        }
        
        interactor.fetchDataPokemon(page: page)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] cards in
                self?.handleSuccessFetch(cards: cards, completion: completion)
            }, onError: { [weak self] error in
                self?.handleErrorFetch(error: error, on: view, page: page, completion: completion)
            })
            .disposed(by: bag)
    }
    
    private func handleSuccessFetch(cards: [PokemonCard], completion: (() -> Void)?) {
        var currentData = page == 1 ? [] : pokemonList.value
        currentData.append(contentsOf: cards)
        pokemonList.accept(currentData)
        
        page += 1
        hasMoreData = !cards.isEmpty
        isLoading = false
        
        completion?()
    }
    
    private func handleErrorFetch(error: Error, on view: UIViewController, page: Int, completion: (() -> Void)?) {
        isLoading = false
        
        showAPIErrorAlert(on: view, error) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
            self.hasMoreData = true
            self.getDataPokemeon(on: view, page: page, completion: completion)
        }
        
        completion?()
    }
    
    func getDetailCard(on view: UIViewController ,cardId: String) {
        interactor.fetchDataCardPokemon(cardId: cardId)
            .subscribe(onNext: {[weak self] card in
                guard let self,
                      let navigation = view.navigationController else { return }
                self.navigateToDetail(from: navigation, pokemonDetail: card.data)
            }, onError: { [weak self] error in
                guard let self else {return}
                self.showAPIErrorAlert(on: view, error) {
                    self.getDetailCard(on: view, cardId: cardId)
                }
            }).disposed(by: bag)
    }
    
    //MARK: - Navigation Handler
    func navigateToDetail(from navigation: UINavigationController, pokemonDetail: PokemonCard) {
        router.navigateToDetail(from: navigation, pokemonDetail: pokemonDetail)
    }
}
