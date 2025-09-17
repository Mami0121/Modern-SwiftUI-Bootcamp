//
//  TaskViewModel.swift
//  Bootcamp_Odevi_5
//
//  Created by Bozkurt on 8.09.2025.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var newTaskTitle: String = ""
    
    // Görev ekleme
    func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        let task = Task(title: newTaskTitle)
        tasks.append(task)
        newTaskTitle = "" // TextField temizlensin
    }
    
    // Görev silme
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    // Tamamlama durumunu değiştirme
    func toggleCompletion(for task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}
