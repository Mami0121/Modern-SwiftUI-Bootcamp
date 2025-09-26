//
//  CharacterRowView.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import SwiftUI
import Kingfisher

struct CharacterRowView: View {
    let character: Character
    let isFavorite: Bool

    var body: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: character.image))
                .placeholder {
                    ProgressView()
                        .frame(width: 60, height: 60)
                }
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.headline)
                Text("\(character.species) - \(character.status)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            if isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 4)
    }
}


