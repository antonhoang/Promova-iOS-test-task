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
    case setAnimals([Animal])
}

class Reducer {
    func update(_ state: inout State, _ action: Action, _ enviroment: EnviromentProtocol) -> State {
        switch action {
        case .getAnimals:
            Task {
                let animals = try await fetchAnimals(enviroment: enviroment)
                let images = try await fetchImages(for: animals, in: enviroment)
                
                let mappedAnimals = zip(animals, images).map {
                    Animal(
                        title: $0.title,
                        description: $0.description,
                        image: $1,
                        order: $0.order,
                        status: $0.status ?? .comingSoon,
                        content: $0.content ?? []
                    )
                }
                
                Task { @MainActor in
                    store.dispatch(.setAnimals(mappedAnimals))
                }
            }
        case .setAnimals(let animals):
            state.animals = animals
            
        }
        return state
    }
    
    func fetchAnimals(enviroment: EnviromentProtocol) async throws -> [AnimalModel] {
         let endpoint = AnimalEndpoint()
         return try await enviroment.network.asyncRequest(endPoint: endpoint, responseModel: [AnimalModel].self)
     }
    
    func fetchImages(for animals: [AnimalModel], in enviroment: EnviromentProtocol) async throws -> [Data] {
         return try await withThrowingTaskGroup(of: Data.self) { group -> [Data] in
             for animal in animals {
                 group.addTask {
                     if let url = URL(string: animal.image) {
                         return try await enviroment.network.asyncLoadImage(url: url)
                     } else {
                         return .init()
                     }
                 }
             }
             return try await group.reduce(into: []) { $0.append($1) }
         }
     }
}

class Store: ObservableObject {
    
    @Published private(set) var state: State
    var reducer: Reducer
    let enviroment: EnviromentProtocol
    
    init(
        state: State,
        reducer: Reducer,
        enviroment: EnviromentProtocol
    ) {
        self.state = state
        self.reducer = reducer
        self.enviroment = enviroment
    }
    
    func dispatch(_ action: Action) {
        state = reducer.update(&state, action, enviroment)
    }
}

protocol EnviromentProtocol {
    var network: NetworkProtocol { get }
}

class Enviroment: EnviromentProtocol {
    let network: NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }
}
