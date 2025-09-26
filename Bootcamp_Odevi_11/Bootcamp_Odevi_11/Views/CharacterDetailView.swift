//
//  CharacterDetailView.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import SwiftUI
import Kingfisher

struct CharacterDetailView: View {
    let characterID: Int
    @StateObject private var vm = CharacterDetailViewModel()

    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView("Yükleniyor...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = vm.errorMessage {
                ErrorView(message: error) {
                    Task { await vm.fetchCharacterDetail(id: characterID) }
                }
            } else if let character = vm.character {
                ScrollView {
                    VStack(spacing: 20) {
                        // GÖRSEL
                        KFImage(URL(string: character.image))
                            .placeholder { ProgressView() }
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .frame(height: 260)
                            .shadow(radius: 5)

                        // ADI
                        Text(character.name)
                            .font(.title)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)

                        // BİLGİLER CARD
                        VStack(spacing: 16) {
                            InfoRow(icon: "heart.circle.fill",
                                    title: "Status",
                                    value: character.status,
                                    valueColor: colorForStatus(character.status))

                            InfoRow(icon: "pawprint.fill",
                                    title: "Species",
                                    value: character.species)

                            InfoRow(icon: "person.fill",
                                    title: "Gender",
                                    value: character.gender)

                            InfoRow(icon: "globe.europe.africa.fill",
                                    title: "Origin",
                                    value: character.origin.name)

                            InfoRow(icon: "location.fill",
                                    title: "Location",
                                    value: character.location.name)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemBackground))
                                .shadow(color: .gray.opacity(0.3), radius: 6, x: 0, y: 3)
                        )
                        .padding(.horizontal)
                    }
                }
            } else {
                Text("Veri bulunamadı")
            }
        }
        .task {
            await vm.fetchCharacterDetail(id: characterID)
        }
        .navigationTitle("Karakter Detayı")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Status rengi
    private func colorForStatus(_ status: String) -> Color {
        switch status.lowercased() {
        case "alive": return .green
        case "dead": return .red
        default: return .gray
        }
    }
}

private struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    var valueColor: Color = .primary

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)

            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Spacer()

            Text(value)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(valueColor)
        }
    }
}

