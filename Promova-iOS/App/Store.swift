//
//  Store.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation
import Combine

//struct State {
//    var products: [Product] = []
//}

protocol Action { }
typealias Reducer<State> = (State, Action) -> State

struct GetProducts: Action {
    
}

class Store<State>: ObservableObject {
    @Published private(set) var state: State
    private let reducer: Reducer<State>
    
    init(state: State, reducer: @escaping Reducer<State>) {
        self.state = state
        self.reducer = reducer
      }
    
    func dispatch(_ action: Action) {
        let newState = reducer(state, action)
        
//        reducer.update(&state, action)
    }
}


//enum Action {
//    case getProducts([Product])
//}

//class Reducer {
//    func update(_ appState: inout State, _ action: Action) {
//        switch action {
//        case .getProducts(let products):
//            appState.products = products
//        }
//    }
//}
