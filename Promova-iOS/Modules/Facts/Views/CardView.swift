//
//  CardView.swift
//  Promova-iOS
//
//  Created by antonhoang on 23/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let content: Content
    @Binding var currentIndex: Int
    let totalCards: Int
    
    @State var isImageLoaded = false

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(width: UIScreen.main.bounds.width * 0.9,
                   height: UIScreen.main.bounds.height / 1.7,
                   alignment: .center
            )
            .shadow(color: Color.black.opacity(0.3),
                    radius: 20, x: 0, y: 20)
            .overlay(
                VStack {
                    AsyncImage(url: URL(string: content.image)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .background(Color.gray)
                                .opacity(isImageLoaded ? 1 : 0)
                                .padding(8)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.5)) {
                                        isImageLoaded = true
                                    }
                                }
                        case .empty:
                            ZStack {
                                Image("placeholder")
                                    .resizable()
                                    .scaledToFit()
                                    .background(Color.gray)
                                    .padding(8)
                                    .opacity(isImageLoaded ? 0 : 1)
                                ProgressView()
                            }
                        default:
                            EmptyView()
                        }
                    }
                    Text(content.fact)
                        .padding()
                    Spacer()
                    HStack {
                        Button(action: {
                            withAnimation {
                                currentIndex = max(currentIndex - 1, 0)
                            }
                        }) {
                            Image("back 1")
                        }
                        .padding()
                        Spacer()
                        Button(action: {
                            withAnimation {
                                currentIndex = min(currentIndex + 1, totalCards - 1)
                            }
                        }) {
                            Image("next 1")
                        }
                        .padding()
                    }
                }
            )
    }
}
