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
                    let shareContent = animal.content[currentIndex].fact
                    let activityViewController = UIActivityViewController(activityItems: [shareContent], applicationActivities: nil)
                    if let windowScene = UIApplication.shared.connectedScenes
                        .filter({ $0.activationState == .foregroundActive })
                        .first as? UIWindowScene,
                        let window = windowScene.windows.first {
                        window.rootViewController?.present(activityViewController, animated: true, completion: nil)
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

struct SwipeCardView: View {
    @Binding var currentIndex: Int

    let animal: Animal

    var body: some View {
        VStack {
            ZStack {
                if animal.content.isEmpty {
                    CardView(
                        content: .init(fact: "Fun facts comming soon...", image: ""),
                        currentIndex: $currentIndex,
                        totalCards: animal.content.count
                    )
                }
                ForEach(animal.content.indices, id: \.self) { index in
                    CardView(
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

struct ActivityView: UIViewControllerRepresentable {
    let text: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [text], applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {}
}
