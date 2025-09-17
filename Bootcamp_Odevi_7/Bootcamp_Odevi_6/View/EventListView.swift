//
//  EventListView.swift
//  Bootcamp_Odevi_6
//
//  Created by Bozkurt on 12.09.2025.
//
import SwiftUI

struct EventListView: View {
    @StateObject private var viewModel = EventViewModel()
    @State private var showAddEvent = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.events) { event in
                    NavigationLink(destination: EventDetailView(event: event, viewModel: viewModel)) {
                        VStack(alignment: .leading) {
                            Text(event.title)
                                .font(.headline)
                            Text(event.date, style: .date)
                                .font(.subheadline)
                            Text(event.type.rawValue)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { viewModel.events[$0] }.forEach(viewModel.deleteEvent)
                }
            }
            .navigationTitle("Etkinlikler")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddEvent = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddEvent) {
                AddEventView(viewModel: viewModel, isPresented: $showAddEvent)
            }
        }
    }
}

#Preview {
    EventListView()
}
