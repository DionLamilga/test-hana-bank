// 
//  DetailPokemonRouter.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import UIKit

class DetailPokemonRouter {
    
    func showView() -> DetailPokemonView {
        let interactor = DetailPokemonInteractor()
        let presenter = DetailPokemonPresenter(interactor: interactor)
        
        let storyboardId = String(describing: DetailPokemonView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? DetailPokemonView else {
            fatalError("Error loading Storyboard")
        }
        view.presenter = presenter
        return view
    }
    
    func backtoPreviousPage(from navigation: UINavigationController) {
        navigation.popViewController(animated: true)
    }
}
