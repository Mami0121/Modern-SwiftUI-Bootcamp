//
//  Note+Extensions.swift
//  Bootcamp_Odevi_9
//
//  Created by Bozkurt on 17.09.2025.
//

import Foundation

extension Note {
    var wrappedId: UUID {
        id ?? UUID()
    }
    var wrappedTitle: String {
        title ?? "Yeni Not"
    }
    var wrappedContent: String {
        content ?? ""
    }
    var wrappedDate: Date {
        date ?? Date()
    }
}
