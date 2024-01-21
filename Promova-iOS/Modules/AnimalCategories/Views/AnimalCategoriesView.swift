//
//  ProductsView.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct AnimalCategoriesView: View {
    
    @EnvironmentObject var store: Store
    
    init() {
        UITableView.appearance().backgroundColor = .init(hex:  0xBEC8FF)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.state.animalState.animals, id: \.title) { animal in
                    ZStack {
                        AnimalCategoriesCellView(animal: .init(
                            title: animal.title,
                            description: animal.description,
                            image: animal.image,
                            order: animal.order,
                            status: animal.status,
                            content: animal.content)
                        )
                        NavigationLink(destination: FactsView(animal: animal), label: { EmptyView() } )
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
                guard store.state.animalState.animals.isEmpty else {
                    return
                }
                store.dispatch(.animal(.getAnimals))
            }
            .navigationBarHidden(true)
        }
    }
}



struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalCategoriesView()
    }
}

