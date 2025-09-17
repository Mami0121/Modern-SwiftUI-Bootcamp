//
//  ContentView.swift
//  Bootcamp_Odevi_9
//
//  Created by Bozkurt on 17.09.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // Note'ları tarihe göre (en yeniden eskiye) çek
    // Read İşlemi: Core Data'dan notları çekiyoruz
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.date, ascending: false)],
        animation: .default)
    private var notes: FetchedResults<Note>

    // Arama çubuğu için state
    @State private var searchText = ""
    @State private var showingAdd = false

    var body: some View {
        NavigationView {
            List {
                ForEach(notes.filter { note in
                    searchText.isEmpty || note.wrappedTitle.localizedCaseInsensitiveContains(searchText)
                }) { note in
                    NavigationLink(destination: EditNoteView(note: note)) {
                        VStack(alignment: .leading) {
                            Text(note.wrappedTitle)
                                .font(.headline)
                            Text(note.wrappedDate, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 6)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Notlarım")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAdd = true }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .searchable(text: $searchText, prompt: "Başlığa göre ara")
            .sheet(isPresented: $showingAdd) {
                AddNoteView()
                    .environment(\.managedObjectContext, viewContext)
            }

            // iPad / geniş ekran için placeholder
            Text("Bir not seçin")
                .foregroundColor(.gray)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print("Silme hatası: \(error.localizedDescription)")
            }
        }
    }
}

// Preview
#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
