//
//  ProductMocks.swift
//  Promova-iOS
//
//  Created by antonhoang on 20/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

class ProductMocks {
    static let mockProducts = [
        ProductCellView(product: .init(
            title: "Title 1",
            description: "Description 1",
            image: "Bitmap",
            order: 1,
            status: .free,
            content: [])
                       ),
        ProductCellView(product: .init(
            title: "Title 2",
            description: "Description 2",
            image: "Bitmap",
            order: 1,
            status: .paid,
            content: [])
                       ),
        ProductCellView(product: .init(
            title: "Title 3",
            description: "Description 3",
            image: "Bitmap",
            order: 1,
            status: .comingSoon,
            content: [])
                       )
    ]
}
