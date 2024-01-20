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

    let product: Product
    var body: some View {
        ZStack {
            Color(UIColor(hex: 0xBEC8FF))
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
        }.ignoresSafeArea()
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(product: mockProducts.first!)
    }
}
