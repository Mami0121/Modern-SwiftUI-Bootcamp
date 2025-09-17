//
//  Persistence.swift
//  Bootcamp_Odevi_9
//
//  Created by Bozkurt on 17.09.2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Preview için in-memory container
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Örnek preview notları
        for i in 0..<5 {
            let newNote = Note(context: viewContext)
            newNote.id = UUID()
            newNote.title = "Örnek Not \(i+1)"
            newNote.content = "Bu, preview için oluşturulmuş örnek içeriktir."
            newNote.date = Date()
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Preview Core Data hatası: \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // ====== BURAYI .xcdatamodeld DOSYAN ADI İLE EŞLEŞTİR ======
        let modelName = "NotesModel" // <- NotesModel.xcdatamodeld olmalı

        // Normal init
        container = NSPersistentContainer(name: modelName)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Persistent store yüklenemedi: \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

