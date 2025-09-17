//
//  ContentView.swift
//  Bootcamp_Odevi_2
//
//  Created by Bozkurt on 27.08.2025.
//

import SwiftUI

// MARK: - Ana Ekran (ContentView)
struct ContentView: View {
    var body: some View {
        ProfileScreen()
    }
}

#Preview {
    ContentView()
}

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderView(
                    name: "Muhammet BOZKURT",
                    subtitle: "iOS Developer"
                )

                StatGrid(stats: [
                    .init(title: "Takipçi", value: "12.4K", systemImage: "person.2.fill"),
                    .init(title: "Takip", value: "387", systemImage: "person.crop.circle.badge.checkmark"),
                    .init(title: "Beğeni", value: "58.1K", systemImage: "heart.fill")
                ])

                AboutSection(
                    text:
"""
Merhaba! iOS geliştirme, arayüz tasarımı ve SwiftUI ile erişilebilir ürünler üretmeyi seviyorum.
Boş zamanlarımda kitap okuyorum ve spor yapıyorum.
Öğrenmeye ve bildiklerimi paylaşmaya her zaman açığım.
"""
                )

                AdaptiveButtons(
                    onMessage: { print("Mesaj Gönder") },
                    onFollow:  { print("Takip Et") }
                )
            }
            .padding(16)
        }
        .background(Color(.systemBackground))
    }
}

struct HeaderView: View {
    var name: String
    var subtitle: String

    var body: some View {
        ZStack(alignment: .bottom) {
            // Gradient zemin
            LinearGradient(
                colors: [Color.purple, Color.blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: .black.opacity(0.15), radius: 16, x: 0, y: 8)

            // İçerik
            VStack(spacing: 8) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 96, height: 96)
                    .foregroundStyle(.white.opacity(0.95))
                    .shadow(radius: 8)

                Text(name)
                    .font(.title2.bold())
                    .foregroundStyle(.white)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(.bottom, 16)
        }
    }
}

struct Stat: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let systemImage: String
}

struct StatGrid: View {
    let stats: [Stat]

    var body: some View {
        Grid(horizontalSpacing: 12, verticalSpacing: 12) {
            GridRow {
                ForEach(stats) { stat in
                    StatCard(stat: stat)
                }
            }
        }
    }
}

struct StatCard: View {
    let stat: Stat

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: stat.systemImage)
                .font(.title3)
            Text(stat.value)
                .font(.headline)
            Text(stat.title)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.thinMaterial)
        )
    }
}

struct AboutSection: View {
    var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hakkımda")
                .font(.headline)
            Text(text)
                .font(.body)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct AdaptiveButtons: View {
    var onMessage: () -> Void
    var onFollow: () -> Void

    var body: some View {
        ViewThatFits(in: .horizontal) {
            // Yan yana sığarsa HStack
            HStack(spacing: 12) {
                messageButton
                followButton
            }

            // Sığmazsa VStack
            VStack(spacing: 12) {
                messageButton
                followButton
            }
        }
    }

    private var messageButton: some View {
        Button(action: onMessage) {
            Label("Mesaj Gönder", systemImage: "envelope.fill")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
    }

    private var followButton: some View {
        Button(action: onFollow) {
            Label("Takip Et", systemImage: "person.badge.plus")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
    }
}

