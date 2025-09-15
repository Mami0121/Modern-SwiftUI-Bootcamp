//
//  NoteViewModel.swift
//  Bootcamp_Odevi_7
//
//  Created by Bozkurt on 15.09.2025.
//
import SwiftUI

class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    private let storage = NoteStorage()
    
    init() {
        notes = storage.load()
    }
    
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.append(newNote)
        storage.save(notes)
    }
    
    func delete(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        storage.save(notes)
    }
}
