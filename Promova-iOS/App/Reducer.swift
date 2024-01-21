//
//  Reducer.swift
//  Promova-iOS
//
//  Created by antonhoang on 21/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

struct Reducer<State, Action, Enviroment> {
    let reduce: (inout State, Action, Enviroment) -> Void
}

let appReducer: Reducer<AppState, AppAction, Enviroment> = Reducer { state, action, enviroment in
    switch action {
    case .getAnimals:
        FetchAnimalMiddleware(environment: enviroment).middleware()(state, action)
    case .setAnimals(let array):
        state.animals = array
    }
}
