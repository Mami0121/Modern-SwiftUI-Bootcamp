//
//  PokemonListView.swift
//  Bootcamp_Odevi_10
//
//  Created by Bozkurt on 21.09.2025.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var vm = PokemonListViewModel()

    var body: some View {
        NavigationView {
            List {
                // Arama Kutusu
                Section {
                    TextField("Pokémon ara...", text: $vm.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 4)
                }

                Section {
                    if vm.isLoading {
                        ProgressView("Yükleniyor...")
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else if let error = vm.errorMessage {
                        VStack(spacing: 12) {
                            Text("Bir hata oluştu").font(.title2)
                            Text(error ?? "Bilinmeyen hata")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Button("Tekrar dene") {
                                Task { await vm.fetchPokemons() }
                            }
                        }
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                    } else {
                        ForEach(vm.filteredPokemons) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                PokemonRowView(pokemon: pokemon)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Pokémonlar")
            .task {
                await vm.fetchPokemons(limit: 100)
            }
        }
    }
}

#Preview {
    PokemonListView()
}










