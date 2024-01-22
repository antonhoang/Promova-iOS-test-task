//
//  SplashScreen.swift
//  Promova-iOS
//
//  Created by antonhoang on 22/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            AnimalCategoriesView()
                .environmentObject(store)
        } else {
            ZStack {
                VStack {
                    VStack {
                        Image("open-book")
                            .font(.system(size: 80))
                        Text("Promova")
                            .font(.system(size: 50))
                            .foregroundColor(Color(UIColor(hex: 0xBEC8FF)))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.8)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation(.easeInOut(duration: 2)) {
                            self.isActive = true
                        }
                    }
                }
            }.ignoresSafeArea()
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
