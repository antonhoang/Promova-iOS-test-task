//
//  Promova_iOSApp.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.

import SwiftUI



let store = StoreFactory().makeStore()

protocol StoreFactoryProtocol {
    func makeStore() -> Store
}

class StoreFactory: StoreFactoryProtocol {
    func makeStore() -> Store {
        let state = AppState(animalState: .init())
        let network = NetworkAPI()
        let enviroment = Enviroment(network: network)
        return Store(state: state, reducer: AppReducer(), enviroment: enviroment)
    }
}

@main
struct Promova_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            ProductsView()
                .environmentObject(store)
        }
    }
}
