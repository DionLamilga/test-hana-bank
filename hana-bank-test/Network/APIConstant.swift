//
//  APIConstant.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import Alamofire

enum PokemonAPI: APIConfig {
    case getCards(params: [String: String]?)
    case getCardDetail(cardId: String)
    
    var path: String {
        switch self {
        case .getCardDetail(let cardId):
            return "/cards/\(cardId)"
        case .getCards:
            return "/cards"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getCards(let params):
            return params
        default:
            return nil
        }
    }
}
