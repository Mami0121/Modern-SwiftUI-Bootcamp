//
//  NoteListView.swift
//  Bootcamp_Odevi_7
//
//  Created by Bozkurt on 15.09.2025.
//
import SwiftUI

struct NoteListView: View {
    @StateObject private var viewModel = NoteViewModel()
    @State private var showAddNote = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.date, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationTitle("Not Defteri")
            .toolbar {
                Button(action: { showAddNote = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddNote) {
                AddNoteView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    NoteListView()
}
