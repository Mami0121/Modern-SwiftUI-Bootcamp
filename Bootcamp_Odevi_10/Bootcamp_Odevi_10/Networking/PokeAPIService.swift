//
//  PokeAPIService.swift
//  Bootcamp_Odevi_10
//
//  Created by Bozkurt on 21.09.2025.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decodingFailure(Error)
    case other(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Geçersiz URL."
        case .invalidResponse: return "Geçersiz yanıt."
        case .statusCode(let code): return "Sunucu hatası: HTTP \(code)."
        case .decodingFailure(let e): return "Veri işlenemedi: \(e.localizedDescription)"
        case .other(let e): return e.localizedDescription
        }
    }
}

final class PokeAPIService {
    func fetchPokemonList(limit: Int = 50) async throws -> [PokemonListItem] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)") else {
            throw APIError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let http = response as? HTTPURLResponse else { throw APIError.invalidResponse }
            guard 200...299 ~= http.statusCode else { throw APIError.statusCode(http.statusCode) }

            do {
                let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                return decoded.results
            } catch {
                throw APIError.decodingFailure(error)
            }
        } catch {
            throw APIError.other(error)
        }
    }
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            throw APIError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let http = response as? HTTPURLResponse, 200...299 ~= http.statusCode else {
                throw APIError.invalidResponse
            }
            do {
                return try JSONDecoder().decode(PokemonDetail.self, from: data)
            } catch {
                throw APIError.decodingFailure(error)
            }
        } catch {
            throw APIError.other(error)
        }
    }
}

