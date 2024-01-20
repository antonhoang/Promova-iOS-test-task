//
//  Promova_iOSApp.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.

import SwiftUI

@main
struct Promova_iOSApp: App {
    var body: some Scene {
        WindowGroup {
//            let state = State()
//            let reducer = Reducer()
//            let store = Store<State>(state: state, reducer: reducer)
            ProductsView()
        }
    }
}
