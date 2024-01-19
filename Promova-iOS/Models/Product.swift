//
//  Product.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

struct Product {
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: ProductState
    let content: [Content]
    
    enum ProductState {
        case free
        case paid
    }
    
    struct Content {
        let fact: String
        let image: String
    }
}
