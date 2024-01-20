//
//  Product.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

struct Animal: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: ProductState
    let content: [Content]
    
    struct Content {
        let fact: String
        let image: String
    }
}

enum ProductState: String, Codable {
    case free
    case paid
    case comingSoon

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = ProductState(rawValue: rawValue) ?? .comingSoon
    }
}


struct AnimalModel: Codable {
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: ProductState?
    let content: [Content]?
    
    struct Content: Codable {
        let fact: String
        let image: String
    }

}
