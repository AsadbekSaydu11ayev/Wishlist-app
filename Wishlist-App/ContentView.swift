//
//  ContentView.swift
//  Wishlist-App
//
//  Created by Asadbek Saydullayev on 17/01/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Wish.createdAt, order: .forward) private var wishes: [Wish]
    @State private var isAlertShowing: Bool = false
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishes) { wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(wish)
                            }
                        }
                }
            } //: LIST
            .navigationTitle("Wishlist")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAlertShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                
//                if wishes.isEmpty != true {
//                    ToolbarItem(placement: .bottomBar) {
//                        Text("\(wishes.count) wish\(wishes.count > 1 ? "es" :  "")")
//                            .frame(width: 150)
//                        
//                    }
//
//                }
            }
            .safeAreaInset(edge: .bottom) {
                if wishes.isEmpty != true {
                    Text("\(wishes.count) wish\(wishes.count > 1 ? "es" :  "")")
                }
            }
            .alert("Create a new wish", isPresented: $isAlertShowing) {
                TextField("Enter a wish", text: $title)
                
                Button {
                    modelContext.insert(Wish(title: title))
                    title = ""
                } label: {
                    Text("Save")
                }
                
                Button("Cancel", role: .cancel) {
                    title = ""
                }
            }
            .overlay {
                if wishes.isEmpty {
                    ContentUnavailableView("My Wishlist", systemImage: "heart.circle", description: Text("Add one to get started"))
                }
            }
        }
    }
}




#Preview("List with Sample Data") {
    let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(Wish(title: "Master SwiftDat"))
    container.mainContext.insert(Wish(title: "Buy a new iphone"))
    container.mainContext.insert(Wish(title: "Practice latin dance"))
    container.mainContext.insert(Wish(title: "Travel to Europe"))
    container.mainContext.insert(Wish(title: "Make a positive impact"))
    
    
    return ContentView()
        .modelContainer(container)
}

#Preview("Empty list") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
