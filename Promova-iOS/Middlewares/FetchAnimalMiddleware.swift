//
//  FetchAnimalMiddleware.swift
//  Promova-iOS
//
//  Created by antonhoang on 21/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

class FetchAnimalMiddleware {
    private let environment: EnviromentProtocol
    
    init(environment: EnviromentProtocol) {
        self.environment = environment
    }
    
    func middleware() -> Middleware<AppState, AppAction> {
        return { [self] state, action in
            switch action {
            case .getAnimals:
                let endpoint = AnimalEndpoint()
                Task {
                    let animals = try await self.environment.network.asyncRequest(endPoint: endpoint, responseModel: [AnimalModel].self)
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
                        store.dispatch(.setAnimals(mappedAnimals))
                    }
                }
            default:
                store.dispatch(action)
            }
        }
    }
}
