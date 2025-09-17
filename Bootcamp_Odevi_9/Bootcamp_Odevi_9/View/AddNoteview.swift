//
//  AddNoteview.swift
//  Bootcamp_Odevi_9
//
//  Created by Bozkurt on 17.09.2025.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var content = ""

    var body: some View {
        NavigationView {
            Form {
                Section("Başlık") {
                    TextField("Başlık girin", text: $title)
                }
                Section("İçerik") {
                    TextEditor(text: $content)
                        .frame(minHeight: 200)
                }
            }
            .navigationTitle("Yeni Not")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") {
                        let vm = NoteViewModel(context: viewContext)
                        vm.addNote(title: title, content: content)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty && content.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") { dismiss() }
                }
            }
        }
    }
}

