//
//  PokemonDetailView.swift
//  Bootcamp_Odevi_10
//
//  Created by Bozkurt on 21.09.2025.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    let pokemon: PokemonListItem
    @StateObject private var vm = PokemonDetailViewModel()

    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView("Yükleniyor...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = vm.errorMessage {
                VStack {
                    Text("Bir hata oluştu")
                    Text(error).font(.caption).foregroundColor(.secondary)
                    Button("Tekrar dene") {
                        Task { await vm.fetchDetail(id: pokemon.id) }
                    }
                }
            } else if let detail = vm.detail {
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // Pokémon resmi ve adı
                        VStack {
                            if let url = detail.sprites.front_default,
                               let imageURL = URL(string: url) {
                                KFImage(imageURL)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .padding()
                            }
                            Text(detail.name.capitalized)
                                .font(.largeTitle)
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        
                        // ID, Boy, Kilo
                        HStack(spacing: 15) {
                            infoCard(title: "ID", value: "\(detail.id)", color: .blue)
                            infoCard(title: "Boy", value: "\(detail.height)", color: .green)
                            infoCard(title: "Kilo", value: "\(detail.weight)", color: .orange)
                        }
                        .frame(maxWidth: .infinity)
                        
                        // Türler kutusu
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Türler")
                                .font(.headline)
                            
                            HStack {
                                ForEach(detail.types, id: \.slot) { slot in
                                    Text(slot.type.name.capitalized)
                                        .font(.subheadline)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.purple.opacity(0.2))
                                        .cornerRadius(15)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        
                        Spacer()
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.1).ignoresSafeArea())
            } else {
                Text("Veri bulunamadı")
            }
        }
        .navigationTitle(pokemon.name.capitalized)
        .task {
            await vm.fetchDetail(id: pokemon.id)
        }
    }
    
    // MARK: - Küçük yardımcı view (renkli kart)
    private func infoCard(title: String, value: String, color: Color) -> some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text(value)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .padding()
        .background(color)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

