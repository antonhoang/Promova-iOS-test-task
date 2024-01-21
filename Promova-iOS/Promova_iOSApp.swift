//
//  Promova_iOSApp.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.

import SwiftUI

typealias AppStore = Store<AppState, AppAction, Enviroment>

let store = StoreFactory().makeStore()

protocol StoreFactoryProtocol {
    func makeStore() -> AppStore
}

class StoreFactory: StoreFactoryProtocol {
    func makeStore() -> AppStore {
        let state = AppState()
        let network = NetworkAPI()
        let enviroment = Enviroment(network: network)
        return Store(state: state, reducer: appReducer, enviroment: enviroment)
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
