//
//  PokemonListViewModel.swift
//  Bootcamp_Odevi_10
//
//  Created by Bozkurt on 21.09.2025.
//

import Foundation

@MainActor
final class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [PokemonListItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""
    
    private let service = PokeAPIService()
    
    var filteredPokemons: [PokemonListItem] {
        if searchText.isEmpty {
            return pokemons
        } else {
            return pokemons.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // async fonksiyon — View .task içinde çağrılacak
    func fetchPokemons(limit: Int = 50) async {
        isLoading = true
        errorMessage = nil
        do {
            let list = try await service.fetchPokemonList(limit: limit)
            pokemons = list
        } catch {
            if let apiErr = error as? APIError {
                errorMessage = apiErr.errorDescription
            } else {
                errorMessage = error.localizedDescription
            }
            pokemons = []
        }
        isLoading = false
    }
}


