//
//  FavoritesViewModel.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import Foundation

@MainActor
final class FavoritesViewModel: ObservableObject {
    static let shared = FavoritesViewModel() // Singleton

    @Published var favorites: [Character] = []
    private let favoritesManager = FavoritesManager.shared

    private init() {
        loadFavorites()
    }

    func loadFavorites() {
        favorites = favoritesManager.loadFavorites()
    }

    func toggleFavorite(_ character: Character) {
        if isFavorite(character) {
            favoritesManager.removeFavorite(character)
        } else {
            favoritesManager.addFavorite(character)
        }
        loadFavorites() // UI anlık güncelleme için
    }

    func isFavorite(_ character: Character) -> Bool {
        favorites.contains(where: { $0.id == character.id })
    }
}

