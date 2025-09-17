//
//  Event.swift
//  Bootcamp_Odevi_6
//
//  Created by Bozkurt on 12.09.2025.
//

import Foundation

enum EventType: String, CaseIterable, Identifiable {
    case birthday = "Doğum Günü"
    case meeting = "Toplantı"
    case holiday = "Tatil"
    case sport = "Spor"
    case other = "Diğer"
    
    var id: String { self.rawValue }
}

struct Event: Identifiable {
    let id = UUID()
    var title: String
    var date: Date
    var type: EventType
    var hasReminder: Bool
}
