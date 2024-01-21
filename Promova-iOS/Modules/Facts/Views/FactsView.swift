//
//  ProductDetails.swift
//  Promova-iOS
//
//  Created by antonhoang on 20/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct FactsView: View {

    @Environment(\.dismiss) var dismiss
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
                cardView
                    .padding()
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
    
    private var cardView: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height / 1.7, alignment: .center)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 20)
            .overlay {
                cardContent
            }
    }
    
    private var cardContent: some View {
        VStack {
            if let im = UIImage(data: animal.image) {
                ZStack {
                    Image(uiImage: im)
                        .resizable()
                        .scaledToFit()
                        .padding(8)
                    
                }
            } else {
                Image("BitmapFullSize")
            }
            Text(animal.content[safe: 0]?.fact ?? "")
                .padding()
            Spacer()
            HStack {
                Button(action: {
                    print("Button tapped!")
                }) {
                    Image("back 1")
                }
                .padding()
                Spacer()
                Button(action: {
                    print("Button tapped!")
                }) {
                    Image("next 1")
                }
                .padding()
                
            }
        }
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FactsView(animal: mockProducts.first!)
        }
    }
}
