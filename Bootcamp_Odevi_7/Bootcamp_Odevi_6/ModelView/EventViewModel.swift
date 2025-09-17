//
//  EventViewModel.swift
//  Bootcamp_Odevi_6
//
//  Created by Bozkurt on 12.09.2025.
//

import SwiftUI

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    // Yeni etkinlik ekleme
    func addEvent(title: String, date: Date, type: EventType, hasReminder: Bool) {
        let newEvent = Event(title: title, date: date, type: type, hasReminder: hasReminder)
        events.append(newEvent)
    }
    
    // Etkinlik silme
    func deleteEvent(_ event: Event) {
        events.removeAll { $0.id == event.id }
    }
    
    // Hatırlatıcı güncelleme
    func toggleReminder(for event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index].hasReminder.toggle()
        }
    }
}
