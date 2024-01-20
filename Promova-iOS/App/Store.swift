//
//  Store.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation
import Combine

let store = Store(state: State(animals: []), reducer: Reducer())

struct State {
    var animals: [Animal]
}

enum Action {
    case getAnimals
    case setAnimals([Animal])
}

class Reducer {
    func update(_ state: inout State, _ action: Action) -> State {
        switch action {
        case .getAnimals:
            let endpoint = AnimalEndpoint()
            Task {
                let result = try await NetworkAPI().asyncRequest(endPoint: endpoint, responseModel: [AnimalModel].self)
                var imagesResult: [Data] = []
                for res in result {
                    do {
                        if let url = URL(string: res.image) {
                            let imageData = try await NetworkAPI().asyncLoadImage(url: url)
                            imagesResult.append(imageData)
                        }
                    }
                }
                let animals = zip(result, imagesResult).map {
                    Animal(title: $0.0.title,
                           description: $0.0.description,
                           image: $0.1,
                           order: $0.0.order,
                           status: $0.0.status ?? .comingSoon,
                           content: $0.0.content ?? [])
                }
                DispatchQueue.main.async {
                    store.dispatch(.setAnimals(animals))                    
                }
            }
        case .setAnimals(let animals):
            state.animals = animals
            
        }
        return state
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
        state = reducer.update(&state, action)
    }
}
