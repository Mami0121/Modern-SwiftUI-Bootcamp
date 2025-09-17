//
//  EventDetailView.swift
//  Bootcamp_Odevi_6
//
//  Created by Bozkurt on 12.09.2025.
//
import SwiftUI

struct EventDetailView: View {
    @Environment(\.dismiss) var dismiss
    var event: Event
    @ObservedObject var viewModel: EventViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text(event.title)
                .font(.largeTitle)
                .bold()
            
            Text(event.date, style: .date)
                .font(.title3)
            
            Text("Tür: \(event.type.rawValue)")
                .font(.headline)
            
            Toggle("Hatırlatıcı", isOn: Binding(
                get: { event.hasReminder },
                set: { _ in viewModel.toggleReminder(for: event) }
            ))
            .padding()
            
            Spacer()
            
            Button(role: .destructive) {
                viewModel.deleteEvent(event)
                dismiss()     
            } label: {
                Text("Etkinliği Sil")
                    .bold()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detay")
    }
}
