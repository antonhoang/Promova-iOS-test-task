//
//  ProductsView.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct ProductsView: View {
    
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            List {
                ForEach(mockProducts) { animal in
                    ZStack {
                        ProductCellView(animal: .init(
                            title: animal.title,
                            description: animal.description,
                            image: animal.image,
                            order: animal.order,
                            status: animal.status,
                            content: animal.content)
                        )
                        NavigationLink(destination: ProductDetails(animal: animal), label: { EmptyView() } )
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
                
                store.dispatch(.getAnimals)
                
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

