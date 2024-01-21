//
//  Reducer.swift
//  Promova-iOS
//
//  Created by antonhoang on 21/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

protocol ReducerProtocol {
    associatedtype State
    associatedtype Action
    associatedtype Environment
    
    func reduce(_ state: inout State, _ action: Action, _ environment: Environment)
}

struct AppState {
    var animalState: AnimalState
}

enum AppAction {
    case animal(AnimalAction)
}

struct AnimalState {
    var animals: [Animal] = []
}

enum AnimalAction {
    case getAnimals
    case setAnimals([Animal])
}

enum ApplAction {
    case animal
}

struct AppReducer {
    func reduce(_ state: inout AppState, _ action: AppAction, _ environment: EnviromentProtocol) {
        switch action {
        case .animal(let animalAction):
            AnimalReducer().reduce(&state.animalState, animalAction, environment)
        }
    }
}

struct AnimalReducer: ReducerProtocol {
    func reduce(_ state: inout AnimalState, _ action: AnimalAction, _ environment: EnviromentProtocol) {
        switch action {
        case .getAnimals:
            let endpoint = AnimalEndpoint()
            Task {
                let animals = try await environment.network.asyncRequest(endPoint: endpoint, responseModel: [AnimalModel].self)
                var imagesData: [Data] = []
                for animal in animals {
                    if let url = URL(string: animal.image) {
                        let imageData = try await environment.network.asyncLoadImage(url: url)
                        imagesData.append(imageData)
                    }
                }
                let mappedAnimals = zip(animals, imagesData).map {
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
                    store.dispatch(.animal(.setAnimals(mappedAnimals)))
                }
            }
        case .setAnimals(let array):
            state.animals = array
        }
    }
}
