//
//  PokemonDetail.swift
//  Bootcamp_Odevi_10
//
//  Created by Bozkurt on 21.09.2025.
//

import Foundation

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonTypeSlot]
    let sprites: Sprites
}

struct PokemonTypeSlot: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

struct Sprites: Codable {
    let front_default: String?
}

