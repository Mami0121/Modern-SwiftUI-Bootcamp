//
//  ContentView.swift
//  Bootcamp_Odevi_4
//
//  Created by Bozkurt on 5.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [Item] = [
        Item(title: "Ödev Yap", description: "SwiftUI liste uygulaması geliştir."),
        Item(title: "Kitap Oku", description: "Her gün en az 20 sayfa oku."),
        Item(title: "Spor Yap", description: "30 dakika yürüyüş yap."),
        Item(title: "Film İzle", description: "Yeni çıkan filmi izle."),
        Item(title: "Alışveriş Yap", description: "Market alışverişini tamamla."),
        Item(title: "Arkadaşını Ara", description: "Uzun zamandır konuşmadığın arkadaşını ara."),
        Item(title: "Blog Yazısı Yaz", description: "Kendi bloğuna kısa bir yazı yaz."),
        Item(title: "Müzik Dinle", description: "Yeni çıkan albümü dinle."),
        Item(title: "Ev Toparla", description: "Odayı temizle ve düzenle."),
        Item(title: "Yeni Tarif Dene", description: "Akşam için farklı bir yemek yap.")
    ]
    
    @State private var newTitle: String = ""
    @State private var newDescription: String = ""
    
    //  Tema renkleri
    private let themeColors: [Color] = [.blue, .green, .purple, .orange, .red, .pink, .teal, .indigo]
    @State private var themeColor: Color = .blue
    
    var body: some View {
        NavigationView {
            List {
                // Tamamlanacaklar
                Section(header: Text("Tamamlanacaklar").foregroundColor(themeColor)) {
                    ForEach(items.filter { !$0.isCompleted }) { item in
                        HStack {
                            NavigationLink(destination: DetailView(item: item)) {
                                VStack(alignment: .leading) {
                                    Text(item.title).font(.headline).foregroundColor(themeColor)
                                    Text(item.description).font(.subheadline).foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                markAsCompleted(item)
                            }) {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(themeColor)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .onDelete { indexSet in
                        deleteItems(at: indexSet, isCompleted: false)
                    }
                }
                
                // Tamamlananlar
                Section(header: Text("Tamamlananlar").foregroundColor(themeColor)) {
                    ForEach(items.filter { $0.isCompleted }) { item in
                        HStack {
                            NavigationLink(destination: DetailView(item: item)) {
                                VStack(alignment: .leading) {
                                    Text(item.title).font(.headline).foregroundColor(themeColor)
                                    Text(item.description).font(.subheadline).foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        deleteItems(at: indexSet, isCompleted: true)
                    }
                }
                
                //  Yeni öğe ekleme
                Section(header: Text("Yeni Öğe Ekle").foregroundColor(themeColor)) {
                    TextField("Başlık", text: $newTitle)
                    TextField("Açıklama", text: $newDescription)
                    
                    Button("Ekle") {
                        guard !newTitle.isEmpty else { return }
                        let newItem = Item(title: newTitle, description: newDescription)
                        items.append(newItem)
                        newTitle = ""
                        newDescription = ""
                    }
                    .foregroundColor(themeColor)
                }
            }
            .navigationTitle("MasterListApp")
            //  Görünüm açıldığında rastgele tema seç
            .onAppear {
                if let randomColor = themeColors.randomElement() {
                    themeColor = randomColor
                }
            }
        }
    }
    
    //  Silme fonksiyonu
    private func deleteItems(at offsets: IndexSet, isCompleted: Bool) {
        let filteredItems = items.enumerated().filter { $0.element.isCompleted == isCompleted }
        let idsToDelete = offsets.map { filteredItems[$0].element.id }
        items.removeAll { idsToDelete.contains($0.id) }
    }
    
    //  Tamamlandı işaretleme fonksiyonu
    private func markAsCompleted(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted = true
        }
    }
}

#Preview {
    ContentView()
}
