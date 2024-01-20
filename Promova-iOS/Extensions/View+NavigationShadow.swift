//
//  View+NavigationShadow.swift
//  Promova-iOS
//
//  Created by antonhoang on 20/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI
import Foundation

extension View {
    func navigationBarShadow(opacity: CGFloat = 0, x: CGFloat = 0, y: CGFloat = 0) -> some View {
        VStack {
            overlay(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(opacity), Color.clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                    .frame(height: y)
            )
        }
    }
}
