//
//  Character.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import Foundation

struct Character: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let origin: Origin
    let location: Location
    
    struct Origin: Codable, Equatable {
        let name: String
    }
    
    struct Location: Codable, Equatable {
        let name: String
    }
}

