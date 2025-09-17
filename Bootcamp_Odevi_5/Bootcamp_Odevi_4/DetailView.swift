//
//  DetailView.swift
//  Bootcamp_Odevi_4
//
//  Created by Bozkurt on 5.09.2025.
//

import SwiftUI

struct DetailView: View {
    var item: Item
    
    // Rastgele SF Symbol seçmek için
    private let symbols = ["star", "heart", "bolt", "book", "flame", "pencil"]
    private var randomSymbol: String {
        symbols.randomElement() ?? "star"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(item.title)
                .font(.largeTitle)
                .bold()
            
            Text(item.description)
                .font(.body)
                .padding()
            
            Image(systemName: randomSymbol)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
        }
        .navigationTitle("Detay")
        .padding()
    }
}
