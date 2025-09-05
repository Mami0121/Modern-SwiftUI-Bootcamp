//
//  Item.swift
//  Bootcamp_Odevi_4
//
//  Created by Bozkurt on 5.09.2025.
//

import Foundation

struct Item: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool = false
}
