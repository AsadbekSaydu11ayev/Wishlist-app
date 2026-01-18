//
//  Wishlist_AppApp.swift
//  Wishlist-App
//
//  Created by Asadbek Saydullayev on 17/01/26.
//

import SwiftUI
import SwiftData

@main
struct Wishlist_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}
