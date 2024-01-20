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
    #warning("if Product State is empty provide an comingSoon")
    enum ProductState: String, Codable {
        case free
        case paid
        case comingSoon
    }
    
    struct Content {
        let fact: String
        let image: String
    }
}



struct AnimalModel: Codable {
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: FactStatus?
    let content: [Content]?
    
    struct Content: Codable {
        let fact: String
        let image: String
    }
    
    enum FactStatus: String, Codable {
        case free
        case paid
        case comingSoon

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = FactStatus(rawValue: rawValue) ?? .comingSoon
        }
    }

}
