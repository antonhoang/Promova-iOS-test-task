//
//  Store.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

struct AppState {
    var animals: [Animal] = []
}

enum AppAction {
    case getAnimals
    case setAnimals([Animal])
}

typealias Middleware<State, Action> = (State, Action) -> ()

class Store<State, Action, Enviroment>: ObservableObject {
    
    @Published private(set) var state: State
    private let reducer: Reducer<State, Action, Enviroment>
    private let enviroment: Enviroment
    
    init(
        state: State,
        reducer: Reducer<State, Action, Enviroment>,
        enviroment: Enviroment
    ) {
        self.state = state
        self.reducer = reducer
        self.enviroment = enviroment
    }
    
    func dispatch(_ action: Action) {
        reducer.reduce(&state, action, enviroment)
    }
}




