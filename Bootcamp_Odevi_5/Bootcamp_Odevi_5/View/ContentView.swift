//
//  ContentView.swift
//  Bootcamp_Odevi_5
//
//  Created by Bozkurt on 8.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Yeni görev ekleme alanı
                HStack {
                    TextField("Yeni görev giriniz...", text: $viewModel.newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        viewModel.addTask()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                // Görev listesi
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Button(action: {
                                viewModel.toggleCompletion(for: task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                            }
                            
                            Text(task.title)
                                .strikethrough(task.isCompleted)
                                .foregroundColor(task.isCompleted ? .gray : .primary)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
            }
            .navigationTitle("Görevlerim")
        }
    }
}

#Preview {
    ContentView()
}
