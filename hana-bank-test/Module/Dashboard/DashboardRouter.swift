// 
//  DashboardRouter.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import UIKit

class DashboardRouter {
    
    func showView() -> DashboardView {
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter(interactor: interactor)
        
        let storyboardId = String(describing: DashboardView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? DashboardView else {
            fatalError("Error loading Storyboard")
        }
        view.presenter = presenter
        return view
    }
    
    func navigateToDetail(from navigation: UINavigationController, pokemonDetail: PokemonCard) {
        let view = DetailPokemonRouter().showView()
        view.presenter?.pokemonDetail = pokemonDetail
        navigation.pushViewController(view, animated: true)
    }
    
}
