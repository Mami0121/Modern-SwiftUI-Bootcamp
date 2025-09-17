//
//  NoteDetailView.swift
//  Bootcamp_Odevi_7
//
//  Created by Bozkurt on 15.09.2025.
//
import SwiftUI

struct NoteDetailView: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(note.title)
                .font(.largeTitle)
                .bold()
            Text(note.date, style: .date)
                .foregroundColor(.gray)
            Divider()
            Text(note.content)
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationTitle("Not Detayı")
    }
}

