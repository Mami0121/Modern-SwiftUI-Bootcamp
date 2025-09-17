//
//  AddNoteView.swift
//  Bootcamp_Odevi_7
//
//  Created by Bozkurt on 15.09.2025.
//
import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: NoteViewModel
    
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Başlık", text: $title)
                TextField("İçerik", text: $content, axis: .vertical)
            }
            .navigationTitle("Yeni Not")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") {
                        viewModel.addNote(title: title, content: content)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") {
                        dismiss()
                    }
                }
            }
        }
    }
}

