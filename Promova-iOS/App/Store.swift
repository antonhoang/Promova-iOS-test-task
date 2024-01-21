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

class Store: ObservableObject {
    
    @Published private(set) var state: AppState
    private let reducer: AppReducer
    private let enviroment: Enviroment
    
    init(
        state: AppState,
        reducer: AppReducer,
        enviroment: Enviroment
    ) {
        self.state = state
        self.reducer = reducer
        self.enviroment = enviroment
    }
    
    func dispatch(_ action: AppAction) {
        reducer.reduce(&state, action, enviroment)
    }
}




