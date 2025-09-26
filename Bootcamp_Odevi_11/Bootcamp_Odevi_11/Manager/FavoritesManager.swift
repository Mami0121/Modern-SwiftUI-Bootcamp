//
//  FavoritesManager.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import Foundation

final class FavoritesManager {
    static let shared = FavoritesManager()
    private let defaults = UserDefaults.standard
    private let key = "favorite_characters"

    private init() {}

    func loadFavorites() -> [Character] {
        guard let data = defaults.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([Character].self, from: data)
        } catch {
            print("Favoriler yüklenemedi: \(error)")
            return []
        }
    }

    func saveFavorites(_ favorites: [Character]) {
        do {
            let data = try JSONEncoder().encode(favorites)
            defaults.set(data, forKey: key)
        } catch {
            print("Favoriler kaydedilemedi: \(error)")
        }
    }

    func addFavorite(_ character: Character) {
        var current = loadFavorites()
        if !current.contains(character) {
            current.append(character)
            saveFavorites(current)
        }
    }

    func removeFavorite(_ character: Character) {
        var current = loadFavorites()
        current.removeAll { $0.id == character.id }
        saveFavorites(current)
    }
}

