//
//  AddEventView.swift
//  Bootcamp_Odevi_6
//
//  Created by Bozkurt on 12.09.2025.
//
import SwiftUI

struct AddEventView: View {
    @ObservedObject var viewModel: EventViewModel
    @Binding var isPresented: Bool
    
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var type: EventType = .other
    @State private var hasReminder: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Etkinlik Bilgileri")) {
                    TextField("Etkinlik Adı", text: $title)
                    DatePicker("Tarih", selection: $date, displayedComponents: .date)
                    
                    Picker("Tür", selection: $type) {
                        ForEach(EventType.allCases) { eventType in
                            Text(eventType.rawValue).tag(eventType)
                        }
                    }
                    
                    Toggle("Hatırlatıcı", isOn: $hasReminder)
                }
            }
            .navigationTitle("Yeni Etkinlik")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Vazgeç") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") {
                        viewModel.addEvent(title: title, date: date, type: type, hasReminder: hasReminder)
                        isPresented = false
                    }
                }
            }
        }
    }
}
