// 
//  DashboardEntity.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import Foundation

struct DetailPokemonCardResponse: Codable {
    let data: PokemonCard
}

struct PokemonCardResponse: Codable {
    let data: [PokemonCard]
}

struct PokemonCard: Codable {
    var id, name: String?
    var level: String?
    var hp: String?
    var evolvesFrom: String?
    var images: PokemonImages?
    var types: [String]?
    var weaknesses: [PokemonDetail]?
    var resistances: [PokemonDetail]?

    enum CodingKeys: String, CodingKey {
        case id, name, level, hp, evolvesFrom
        case images, types, weaknesses, resistances
    }
    
    var isSkeleton: Bool {
        return id == nil && name == nil
    }
}

struct PokemonImages: Codable {
    let small, large: String?
}

struct PokemonDetail: Codable {
    let type, value: String?
}
