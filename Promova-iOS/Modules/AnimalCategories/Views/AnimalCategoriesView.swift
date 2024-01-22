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
    @State var showAlert = false
    @State var showFacts = false
    @State var showAd = false
    @State var selectedItem: Animal?
    
    init() {
        UITableView.appearance().backgroundColor = .init(hex:  0xBEC8FF)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LoadingView(isShowing: $showAd) {
                    List {
                        ForEach(store.state.animalState.animals, id: \.id) { animal in
                            ZStack {
                                AnimalCategoriesCellView(animal: .init(
                                    title: animal.title,
                                    description: animal.description,
                                    image: animal.image,
                                    order: animal.order,
                                    status: animal.status,
                                    content: animal.content)
                                )
                            }
                            .onTapGesture {
                                showAlert = animal.status != .free
                                showFacts = !showAlert
                                selectedItem = animal
                            }
                        }
                        .background(NavigationLink(destination: FactsView(animal: selectedItem ?? .init()), isActive: $showFacts, label: { EmptyView() }))
                        .background(Color.white)
                        .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    .alert(isPresented: $showAlert) {
                        let emptyAlert = Alert(title: Text(""), dismissButton: .cancel())
                        if let selectedItem = selectedItem {
                            switch selectedItem.status {
                            case .paid:
                                return Alert(
                                    title: Text("Watch Ad to continue"),
                                    primaryButton: .default(Text("Show Ad")) {
                                        showAd = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            showAd = false
                                            showFacts = !showAd
                                        }
                                    },
                                    secondaryButton: .cancel())
                            case .comingSoon:
                                return Alert(
                                    title: Text("Cooming Soon"),
                                    dismissButton: .default(Text("Ok")))
                            default: return emptyAlert
                            }
                        }
                        return emptyAlert
                    }
                    .onAppear {
                        guard store.state.animalState.animals.isEmpty else {
                            return
                        }
                        store.dispatch(.animal(.getAnimals))
                    }
                    .navigationBarHidden(true)
                    .padding([.top], 20)
                }.ignoresSafeArea()
            }
        }
    }
}

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .opacity(isShowing ? 1 : 0)
            }
        }
    }
    
}



struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalCategoriesView()
    }
}

