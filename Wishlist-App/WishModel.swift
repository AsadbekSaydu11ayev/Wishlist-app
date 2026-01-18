//
//  WishModel.swift
//  Wishlist-App
//
//  Created by Asadbek Saydullayev on 18/01/26.
//

import Foundation
import SwiftData

@Model
class Wish {
    var title: String
    var createdAt: Date
    
    init(title: String) {
        self.title = title
        self.createdAt = Date()
    }
}
