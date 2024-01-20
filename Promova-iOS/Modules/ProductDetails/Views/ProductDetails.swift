//
//  ProductDetails.swift
//  Promova-iOS
//
//  Created by antonhoang on 20/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct ProductDetails: View {
//    @EnvironmentObject private var store: Store
    @Environment(\.dismiss) var dismiss
    let product: Product

    init(product: Product) {
        self.product = product
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
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height / 1.7, alignment: .center)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 20)
                    .overlay {
                        VStack {
                            Image("BitmapFullSize")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                            Text("Fact text")
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
                    .padding()
                Spacer()
            }

        }
        .navigationBarTitle("Category Title", displayMode: .inline)
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

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetails(product: mockProducts.first!)
        }
    }
}
