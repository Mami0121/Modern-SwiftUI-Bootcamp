//
//  ContentView.swift
//  Bootcamp_Odevi_3
//
//  Created by Bozkurt on 3.09.2025.
//

import SwiftUI

struct CounterView: View {
    
    @State private var count: Int = 0

    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                
                Text("Sayaç Uygulaması")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                
                
                Text("\(count)")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 200)
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .shadow(radius: 10)
                    )
                
                
                HStack(spacing: 40) {
                    Button(action: {
                        count = max(0, count - 1)
                    }) {
                        Text("➖ Azalt")
                            .font(.headline)
                            .frame(width: 120, height: 50)
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    
                    Button(action: {
                        count += 1
                    }) {
                        Text("➕ Artır")
                            .font(.headline)
                            .frame(width: 120, height: 50)
                            .background(Color.green.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CounterView()
}
