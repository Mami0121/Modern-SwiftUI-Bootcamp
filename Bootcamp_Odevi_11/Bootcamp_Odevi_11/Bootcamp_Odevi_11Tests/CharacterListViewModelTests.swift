//
//  CharacterListViewModelTests.swift
//  Bootcamp_Odevi_11Tests
//
//  Created by Bozkurt on 25.09.2025.
//

//  Bu dosya, CharacterListViewModel için yazılmış birim testlerini içerir.
//  - Kullanılan mock: MockNetworkService (gerçek API yerine sahte cevaplar veriyor).
//  - Amaç: ViewModel’in başarılı ve hatalı senaryolarda nasıl davrandığını doğrulamak.
//
//  Yazdığımız testler:
//  1. testFetchCharacters_successfulParsing
//     ✅ Mock servis bir karakter döndürüyor mu, ViewModel bunu alıp karakter listesine ekliyor mu?
//     Beklenen: viewModel.characters boş olmamalı.
//
//  2. testFetchCharacters_failure
//     ✅ Mock servis hata fırlatınca, ViewModel doğru şekilde errorMessage set ediyor mu?
//     Beklenen: viewModel.characters boş kalmalı, errorMessage nil olmamalı.
//
//  Sonuç: Her iki test de başarılı geçti (passed).
//

import XCTest
@testable import Bootcamp_Odevi_11

@MainActor
final class CharacterListViewModelTests: XCTestCase {
    var mockService: MockNetworkService!
    var viewModel: CharacterListViewModel!

    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        viewModel = CharacterListViewModel(service: mockService)
    }

    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }

    // Test 1: JSON parse doğrulaması (Network katmanı mock)
    func testFetchCharacters_successfulParsing() async throws {
        // Arrange
        let sampleCharacter = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            gender: "Male",
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            origin: Character.Origin(name: "Earth"),
            location: Character.Location(name: "Citadel of Ricks")
        )
        mockService.mockCharacters = [sampleCharacter]

        // Act
        await viewModel.fetchCharacters()

        // Assert
        XCTAssertFalse(viewModel.characters.isEmpty)
        XCTAssertEqual(viewModel.characters.first?.name, "Rick Sanchez")
        XCTAssertNil(viewModel.errorMessage)
    }

    // Test 2: ViewModel hata durumu testi
    func testFetchCharacters_failure() async {
        // Arrange
        mockService.shouldReturnError = true

        // Act
        await viewModel.fetchCharacters()

        // Assert
        XCTAssertTrue(viewModel.characters.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}


