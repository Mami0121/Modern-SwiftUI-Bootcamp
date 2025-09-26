//
//  MockNetworkService.swift
//  Bootcamp_Odevi_11Tests
//
//  Created by Bozkurt on 25.09.2025.
//

//  Bu dosya, gerçek API çağrılarını taklit eden (mock) bir servis sınıfıdır.
//  - Amacımız: Network katmanını testlerde izole edip, gerçek istek atmak yerine sahte cevaplar döndürmek.
//  - shouldReturnError değişkeni ile: Başarısız (error) senaryosunu test edebiliyoruz.
//  - mockCharacters ve mockCharacterDetail ile: Başarılı senaryoda elimizdeki örnek veriyi döndürüyoruz.
//
//  Yani bu sınıf sayesinde testlerimiz dış bağımlılıktan kurtulup
//  sadece ViewModel’in davranışını ölçebiliyoruz.

import Foundation
@testable import Bootcamp_Odevi_11

final class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError = false
    var mockCharacters: [Character] = []
    var mockCharacterDetail: Character?

    func fetchCharacters(page: Int, name: String?) async throws -> APIResponse {
        if shouldReturnError {
            throw APIError.requestFailed
        }
        return APIResponse(
            info: APIResponse.Info(
                count: mockCharacters.count,
                pages: 1,
                next: nil,
                prev: nil
            ),
            results: mockCharacters
        )
    }

    func fetchCharacterDetail(id: Int) async throws -> Character {
        if shouldReturnError {
            throw APIError.requestFailed
        }
        guard let detail = mockCharacterDetail else {
            throw APIError.unknown
        }
        return detail
    }
}



