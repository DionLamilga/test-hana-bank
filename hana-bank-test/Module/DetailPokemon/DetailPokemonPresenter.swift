// 
//  DetailPokemonPresenter.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import UIKit

class DetailPokemonPresenter {
    
    private let interactor: DetailPokemonInteractor
    private let router = DetailPokemonRouter()
    
    var pokemonDetail: PokemonCard? = nil
    
    init(interactor: DetailPokemonInteractor) {
        self.interactor = interactor
    }
    
    func backtoPreviousPage(from navigation: UINavigationController) {
        router.backtoPreviousPage(from: navigation)
    }
}
