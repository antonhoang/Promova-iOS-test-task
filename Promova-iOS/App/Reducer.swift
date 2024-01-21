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

struct AppReducer {
    func reduce(_ state: inout AppState, _ action: AppAction, _ environment: EnviromentProtocol) {
        switch action {
        case .animal(let animalAction):
            AnimalReducer().reduce(&state.animalState, animalAction, environment)
        }
    }
}

