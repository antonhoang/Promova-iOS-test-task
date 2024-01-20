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
            productImage
            VStack(alignment: .leading) {
                productTitle
                productDescription
                
                statusView(for: .paid)
                    .padding([.top])
                
            }
            .padding([.top], 4)
            Spacer()
            statusView(for: .comingSoon)
        }
        .overlay(product.status == .comingSoon ? Color.black.opacity(0.6) : Color.clear)
    }
    
    struct StatusView: View {
        let imageName: String
        let statusText: String
        let statusColor: Color
        
        var body: some View {
            HStack {
                Image(imageName)
                Text(statusText)
                    .foregroundColor(Color(red: 8/255, green: 58/255, blue: 235/255))

            }
        }
    }
    
    @ViewBuilder
    private func statusView(for status: Product.ProductState) -> some View {
        if product.status == status {
            switch status {
            case .paid:
                StatusView(
                    imageName: "Shape",
                    statusText: "Premium",
                    statusColor: Color("083AEB"))
            case .comingSoon:
                StatusView(
                    imageName: "coming-soon 1",
                    statusText: "",
                    statusColor: .clear)
            default:
                EmptyView()
            }
        } else {
            EmptyView()
        }
    }
    
    private var productImage: some View {
        Image(product.image)
            .aspectRatio(contentMode: .fit)
            .padding(8)
    }
    
    private var productTitle: some View {
        Text(product.title)
            .font(.headline)
            .foregroundColor(.black)
    }
    
    private var productDescription: some View {
        Text(product.description)
            .font(.subheadline)
            .foregroundColor(.gray)
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: .init(
            title: "Title",
            description: "Description",
            image: "Bitmap",
            order: 1,
            status: .comingSoon,
            content: [])
        )
    }
}
