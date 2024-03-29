//
//  AnimalReducer.swift
//  Promova-iOS
//
//  Created by antonhoang on 21/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

struct AnimalReducer: ReducerProtocol {

    func reduce(
        _ state: inout AnimalState,
        _ action: AnimalAction,
        _ environment: EnviromentProtocol
    ) {
        switch action {
        case .getAnimals:
            let endpoint = AnimalEndpoint()
            Task {
                let animals = try await environment.network.asyncRequest(endPoint: endpoint, responseModel: [AnimalModel].self)
                let mappedAnimals = animals.map {
                    Animal(
                        title: $0.title,
                        description: $0.description,
                        imageURL: $0.image,
                        order: $0.order,
                        status: $0.status ?? .comingSoon,
                        content: $0.content ?? []
                    )
                }.sorted(by: { $0.order < $1.order })
                                
                Task { @MainActor in
                    store.dispatch(.animal(.setAnimals(mappedAnimals)))
                }
            }
        case .setAnimals(let animals):
            state.animals = animals
        }
    }
}
