//
//  NoteViewModel.swift
//  Bootcamp_Odevi_9
//
//  Created by Bozkurt on 17.09.2025.
//


import Foundation
import CoreData

class NoteViewModel: ObservableObject {
    private let viewContext: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }

    // Create
    func addNote(title: String, content: String) {
        let newNote = Note(context: viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.content = content
        newNote.date = Date()
        saveContext()
    }

    // Update
    func update(note: Note, title: String, content: String) {
        note.title = title
        note.content = content
        note.date = Date()
        saveContext()
    }

    // Delete
    func delete(note: Note) {
        viewContext.delete(note)
        saveContext()
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Core Data save error: \(error.localizedDescription)")
        }
    }
}

