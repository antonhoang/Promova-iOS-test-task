//
//  Store.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation
import Combine

struct State {
    var animals: [Animal]
}

enum Action {
    case getAnimals
}

class Reducer {
    func update(_ state: inout State, _ action: Action) {
        switch action {
        case .getAnimals:
            let endpoint = AnimalEndpoint()
            Task {
                let result = try await NetworkAPI().asyncRequest(endPoint: endpoint, responseModel: [AnimalModel].self)
//                state.animals = result
            }
            
        }
    }
}

class Store: ObservableObject {
    
    @Published private(set) var state: State
    var reducer: Reducer
    
    init(state: State, reducer: Reducer) {
        self.state = state
        self.reducer = reducer
    }
    
    func dispatch(_ action: Action) {
        reducer.update(&state, action)
    }
}
