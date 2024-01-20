//
//  Product.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: ProductState
    let content: [Content]
    
    enum ProductState {
        case free
        case paid
        case comingSoon
    }
    
    struct Content {
        let fact: String
        let image: String
    }
}
