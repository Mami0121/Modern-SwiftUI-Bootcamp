//
//  CharacterDetailViewModel.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import Foundation

@MainActor
final class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: NetworkServiceProtocol

    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }

    func fetchCharacterDetail(id: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            let detail = try await service.fetchCharacterDetail(id: id)
            self.character = detail
        } catch {
            if let apiError = error as? APIError {
                errorMessage = apiError.localizedDescription
            } else {
                errorMessage = error.localizedDescription
            }
        }

        isLoading = false
    }
}

