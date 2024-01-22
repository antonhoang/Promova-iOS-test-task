//
//  ProductDetails.swift
//  Promova-iOS
//
//  Created by antonhoang on 20/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI
import Combine

struct FactsView: View {

    @Environment(\.dismiss) var dismiss
    @State var selection = 0
    let animal: Animal

    init(animal: Animal) {
        self.animal = animal
    }
    
    var body: some View {
        ZStack {
            Color(UIColor(hex: 0xBEC8FF)).ignoresSafeArea()
            VStack {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 0, alignment: .top)
                    .navigationBarShadow(opacity: 0.25, x: 0, y: 8)
                    .padding([.top], 20)
                Spacer()
                
                TabView {
                    ZStack {
                        Color(UIColor(hex: 0xBEC8FF))
                        SwipeCardView(animal: animal)
                    }
                }
                .tabViewStyle(.page)
                Spacer()
            }

        }
        .navigationBarTitle(animal.title, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("Path")
                    }
                })
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SwipeCardView(animal: .init())
        }
    }
}

struct SwipeCardView: View {
    @State private var currentIndex: Int = 0

    let animal: Animal

    var body: some View {
        VStack {
            ZStack {
                ForEach(animal.content.indices, id: \.self) { index in
                    CardView(
                        id: animal.id,
                        imageData: animal.image,
                        content: animal.content[index],
                        currentIndex: $currentIndex,
                        totalCards: animal.content.count
                    )
                    .offset(x: cardOffset(for: index))
                }
            }
            Spacer()
        }
    }

    private func cardOffset(for index: Int) -> CGFloat {
        let cardWidth = UIScreen.main.bounds.width
        return CGFloat(index - currentIndex) * (cardWidth )
    }
}

struct CardView: View {
    let id: UUID
    let imageData: Data
    let content: Content
    @Binding var currentIndex: Int
    let totalCards: Int

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
                    if let image = ImageLoader.imageCache[id] {
                        image
                            .resizable()
                            .scaledToFit()
                            .background(Color.gray)
                            .padding(8)
                    } else {
                        AsyncImageLoader(id: id, imageData: imageData)
                            .background(Color.gray)
                            .padding(8)
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





