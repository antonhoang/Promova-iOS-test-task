//
//  LoadingView.swift
//  Promova-iOS
//
//  Created by antonhoang on 22/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .opacity(isShowing ? 1 : 0)
            }
        }
    }
    
}
