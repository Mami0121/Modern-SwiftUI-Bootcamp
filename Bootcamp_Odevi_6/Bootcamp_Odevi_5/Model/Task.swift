//
//  Task.swift
//  Bootcamp_Odevi_5
//
//  Created by Bozkurt on 8.09.2025.
//

import Foundation

struct Task: Identifiable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
