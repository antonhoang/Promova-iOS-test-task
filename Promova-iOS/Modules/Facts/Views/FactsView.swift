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
    @State private var currentIndex: Int = 0

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
                    .padding([.vertical], 20)
                Spacer()
                
                TabView {
                    ZStack {
                        Color(UIColor(hex: 0xBEC8FF))
                            .ignoresSafeArea()
                        SwipeCardView(currentIndex: $currentIndex, animal: animal)
                    }
                }
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
                },
            trailing:
                Button(action: {
                    if !animal.content.isEmpty {
                        let shareContent = animal.content[currentIndex].fact
                        let activityViewController = UIActivityViewController(activityItems: [shareContent], applicationActivities: nil)
                        if let windowScene = UIApplication.shared.connectedScenes
                            .filter({ $0.activationState == .foregroundActive })
                            .first as? UIWindowScene,
                           let window = windowScene.windows.first {
                            window.rootViewController?.present(
                                activityViewController, animated: true, completion: nil
                            )
                        }
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.black)
                })
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SwipeCardView(currentIndex: .constant(0), animal: .init())
        }
    }
}

