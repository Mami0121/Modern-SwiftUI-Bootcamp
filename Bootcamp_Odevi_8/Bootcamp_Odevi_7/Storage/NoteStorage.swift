//
//  NoteStorage.swift
//  Bootcamp_Odevi_7
//
//  Created by Bozkurt on 15.09.2025.
//
import Foundation

class NoteStorage {
    private let key = "notes_key"
    
    func save(_ notes: [Note]) {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func load() -> [Note] {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Note].self, from: data) {
            return decoded
        }
        return []
    }
}

