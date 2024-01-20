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

    init(product: Product) {
        self.product = product
//        let shadowColor = UIColor.black
//                let shadowImage = UIImage(color: shadowColor, size: CGSize(width: 1, height: 9 / UIScreen.main.scale))
//                let alphaImage = shadowImage?.withAlpha(0.5)
//                
//                let coloredAppearance = UINavigationBarAppearance()
//                coloredAppearance.backgroundColor = .green
//                coloredAppearance.shadowImage = alphaImage
//                coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//
//                UINavigationBar.appearance().standardAppearance = coloredAppearance
//                UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
      }
    let product: Product
    var body: some View {
        ZStack {
            Color(UIColor(hex: 0xBEC8FF))
            NavigationBarShadowView()
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
            
//            VStack {
////                Spacer()
//                Rectangle()
//                    .fill(Color.black.opacity(0.25))
//                    .frame(height: 4)
//            }
        }.ignoresSafeArea()
            .navigationBarShadow(opacity: 0.25, x: 0, y: 4)
            .navigationBarTitle("Category Title", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    HStack {
                        Button(action: {
                        }) {
                            Image("Path")
                        }
                    })
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.shadowColor = nil // or a custom tint color
                appearance.shadowImage = UIImage(named: "shadow")
                UINavigationBar.appearance().standardAppearance = appearance
            }
    }
}

struct NavigationBarShadowView: View {
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(Color.black.opacity(0.25))
                .frame(height: 4)
        }
    }
}

extension View {
    func navigationBarShadow(opacity: CGFloat = 0, x: CGFloat = 0, y: CGFloat = 0) -> some View {
        VStack {
            
            self.overlay(
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
