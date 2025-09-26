//
//  CharacterListViewModel.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import Foundation

@MainActor
final class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""

    private let service: NetworkServiceProtocol
    private var currentPage = 1
    private var canLoadMore = true

    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }

    func fetchCharacters(reset: Bool = false) async {
        if reset {
            currentPage = 1
            characters.removeAll()
            canLoadMore = true
        }
        
        guard canLoadMore else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await service.fetchCharacters(page: currentPage, name: searchText)
            characters.append(contentsOf: response.results)
            canLoadMore = response.info.next != nil
            currentPage += 1
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

