//
//  ProductDetails.swift
//  Promova-iOS
//
//  Created by antonhoang on 20/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct ProductDetails: View {
    let product: Product
    var body: some View {
        Text(product.title)
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(product: mockProducts.first!)
    }
}
