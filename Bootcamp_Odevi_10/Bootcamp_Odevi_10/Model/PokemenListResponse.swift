//
//  PokemenListResponse.swift
//  Bootcamp_Odevi_10
//
//  Created by Bozkurt on 21.09.2025.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable, Identifiable {
    let name: String
    let url: String

    // id'i url'den ayıkla: ".../pokemon/1/" -> 1
    var id: Int {
        let trimmed = url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        if let last = trimmed.split(separator: "/").last, let n = Int(last) {
            return n
        }
        return -1
    }

    // Hafif, hızlı sprite resmi (PokeAPI'nın GitHub sprite'ları)
    var imageURL: URL? {
        guard id >= 0 else { return nil }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}

