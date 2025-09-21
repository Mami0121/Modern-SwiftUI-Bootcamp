//
//  PokemonDetailViewModel.swift
//  Bootcamp_Odevi_10
//
//  Created by Bozkurt on 21.09.2025.
//

import Foundation

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published var detail: PokemonDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = PokeAPIService()

    func fetchDetail(id: Int) async {
        isLoading = true
        errorMessage = nil
        do {
            detail = try await service.fetchPokemonDetail(id: id)
        } catch {
            if let apiErr = error as? APIError {
                errorMessage = apiErr.errorDescription
            } else {
                errorMessage = error.localizedDescription
            }
            detail = nil
        }
        isLoading = false
    }
}

