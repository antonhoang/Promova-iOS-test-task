//
//  ProductCellView.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct ProductCellView: View {
    
    let product: Product
    
    var body: some View {
        HStack(alignment: .top) {
            Image(product.image)
                .aspectRatio(contentMode: .fit)
                .padding(8)
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(product.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(8)
            Spacer()
        }
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: .init(
            title: "Title",
            description: "Description",
            image: "Bitmap",
            order: 1,
            status: .free,
            content: [])
        )
    }
}
