//
//  EditNoteView.swift
//  Bootcamp_Odevi_9
//
//  Created by Bozkurt on 17.09.2025.
//

import SwiftUI

struct EditNoteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var note: Note
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var content: String = ""

    var body: some View {
        Form {
            Section("Başlık") {
                TextField("Başlık", text: $title)
            }
            Section("İçerik") {
                TextEditor(text: $content)
                    .frame(minHeight: 200)
            }
        }
        .navigationTitle("Notu Düzenle")
        .onAppear {
            title = note.wrappedTitle
            content = note.wrappedContent
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Kaydet") {
                    let vm = NoteViewModel(context: viewContext)
                    vm.update(note: note, title: title, content: content)
                    dismiss()
                }
            }
        }
    }
}

