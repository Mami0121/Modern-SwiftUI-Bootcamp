//
//  APIError.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case decodingError
    case serverError(Int)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL."
        case .requestFailed:
            return "Ağ isteği başarısız oldu."
        case .decodingError:
            return "Veri çözümlenemedi."
        case .serverError(let code):
            return "Sunucu hatası. Kod: \(code)"
        case .unknown:
            return "Bilinmeyen bir hata oluştu."
        }
    }
}

