//
//  ErrorView.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Hata")
                .font(.title)
                .foregroundColor(.red)
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            Button("Tekrar Dene", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

