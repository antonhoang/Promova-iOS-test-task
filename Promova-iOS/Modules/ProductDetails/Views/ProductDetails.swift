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
        ZStack {
            Color(UIColor(hex: 0xBEC8FF))
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 335, height: 435, alignment: .center)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 20)
                .overlay {
                    VStack {
                        Image("BitmapFullSize")
                    }
                }
                .padding()
        }        
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(product: mockProducts.first!)
    }
}
