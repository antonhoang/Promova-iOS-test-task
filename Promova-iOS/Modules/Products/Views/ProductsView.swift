//
//  ProductsView.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct ProductsView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(mockProducts) { product in
                    ZStack {
                        ProductCellView(product: .init(
                            title: product.title,
                            description: product.description,
                            image: product.image,
                            order: product.order,
                            status: product.status,
                            content: product.content)
                        )
                        NavigationLink(destination: ProductDetails(product: product), label: { EmptyView() } )
                    }
                }
                .background(Color.white)
                .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            }
            .onAppear {
                UITableView.appearance().backgroundColor = .init(hex:  0xBEC8FF)
            }
            .navigationBarHidden(true)
        }
    }
}



struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}

