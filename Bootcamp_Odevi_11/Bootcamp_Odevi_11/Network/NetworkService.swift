//
//  NetworkService.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCharacters(page: Int, name: String?) async throws -> APIResponse
    func fetchCharacterDetail(id: Int) async throws -> Character
}

final class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://rickandmortyapi.com/api"

    func fetchCharacters(page: Int, name: String? = nil) async throws -> APIResponse {
        var components = URLComponents(string: "\(baseURL)/character")!
        var queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        
        if let name = name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200:
            do {
                return try JSONDecoder().decode(APIResponse.self, from: data)
            } catch {
                throw APIError.decodingError
            }
        case 400...499:
            throw APIError.requestFailed
        case 500...599:
            throw APIError.serverError(httpResponse.statusCode)
        default:
            throw APIError.unknown
        }
    }

    func fetchCharacterDetail(id: Int) async throws -> Character {
        guard let url = URL(string: "\(baseURL)/character/\(id)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200:
            do {
                return try JSONDecoder().decode(Character.self, from: data)
            } catch {
                throw APIError.decodingError
            }
        case 400...499:
            throw APIError.requestFailed
        case 500...599:
            throw APIError.serverError(httpResponse.statusCode)
        default:
            throw APIError.unknown
        }
    }
}


