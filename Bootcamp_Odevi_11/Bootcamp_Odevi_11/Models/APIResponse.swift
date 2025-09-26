//
//  APIResponse.swift
//  Bootcamp_Odevi_11
//
//  Created by Bozkurt on 24.09.2025.
//

import Foundation

struct APIResponse: Codable {
    let info: Info
    let results: [Character]
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}

