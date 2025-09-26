//
//  CharacterListView.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var vm = CharacterListViewModel()
    @StateObject private var favoritesVM = FavoritesViewModel.shared

    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading && vm.characters.isEmpty {
                    ProgressView("Yükleniyor...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = vm.errorMessage {
                    ErrorView(message: error) {
                        Task { await vm.fetchCharacters(reset: true) }
                    }
                } else if vm.characters.isEmpty {
                    Text("Sonuç bulunamadı")
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach(vm.characters) { character in
                            NavigationLink(destination: CharacterDetailView(characterID: character.id)) {
                                CharacterRowView(
                                    character: character,
                                    isFavorite: favoritesVM.isFavorite(character)
                                )
                            }
                            .swipeActions {
                                Button {
                                    favoritesVM.toggleFavorite(character)
                                } label: {
                                    if favoritesVM.isFavorite(character) {
                                        Label("Favorilerden Kaldır", systemImage: "heart.slash")
                                    } else {
                                        Label("Favorilere Ekle", systemImage: "heart")
                                    }
                                }
                                .tint(.blue)
                            }
                        }

                        if vm.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        } else if !vm.characters.isEmpty {
                            Button("Daha Fazla Yükle") {
                                Task { await vm.fetchCharacters() }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .refreshable {
                        await vm.fetchCharacters(reset: true)
                    }
                }
            }
            .navigationTitle("Rick & Morty")
            .searchable(text: $vm.searchText, prompt: "Karakter ara")
            .onChange(of: vm.searchText) { _ in
                Task { await vm.fetchCharacters(reset: true) }
            }
            .task {
                await vm.fetchCharacters()
            }
            .toolbar {
                NavigationLink(destination: FavoritesView()) {
                    Image(systemName: "heart.fill")
                }
            }
        }
    }
}

#Preview {
    CharacterListView()
}
