//
//  FavoritesView.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import SwiftUI
import Kingfisher

struct FavoritesView: View {
    @StateObject private var vm = FavoritesViewModel.shared

    var body: some View {
        Group {
            if vm.favorites.isEmpty {
                Text("Henüz favori eklenmedi.")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(vm.favorites) { character in
                        NavigationLink(destination: CharacterDetailView(characterID: character.id)) {
                            CharacterRowView(
                                character: character,
                                isFavorite: true
                            )
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let character = vm.favorites[index]
                            vm.toggleFavorite(character) // Favoriden kaldır
                        }
                    }
                }
            }
        }
        .navigationTitle("Favoriler")
        .onAppear {
            vm.loadFavorites()
        }
    }
}


