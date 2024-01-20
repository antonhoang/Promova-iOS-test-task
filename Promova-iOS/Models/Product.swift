//
//  Product.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

struct Animal {
    let title: String
    let description: String
    let image: Data
    let order: Int
    let status: ProductState
    let content: [Content]
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


struct Content: Codable {
    let fact: String
    let image: String
}

struct AnimalModel: Codable {
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: ProductState?
    let content: [Content]?

}
