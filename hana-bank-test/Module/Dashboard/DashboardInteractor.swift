// 
//  DashboardInteractor.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import Foundation
import RxSwift

class DashboardInteractor: BaseInteractor {
    func fetchDataPokemon(page: Int) -> Observable<[PokemonCard]> {
        let param: [String: String] = [
            "page": "\(page)",
            "pageSize": "8"
        ]
        return APIClient.request(
            url: PokemonAPI.getCards(params: param),
            forModel: PokemonCardResponse.self
        )
        .map { $0.data }
    }
    
    func fetchDataCardPokemon(cardId: String) -> Observable<DetailPokemonCardResponse> {
        return APIClient.request(
            url: PokemonAPI.getCardDetail(cardId: cardId),
            forModel: DetailPokemonCardResponse.self
        )
    }
}
