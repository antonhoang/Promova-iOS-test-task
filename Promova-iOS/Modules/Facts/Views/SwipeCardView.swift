//
//  SwipeCardView.swift
//  Promova-iOS
//
//  Created by antonhoang on 23/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct SwipeCardView: View {
    @Binding var currentIndex: Int

    let animal: Animal

    var body: some View {
        VStack {
            ZStack {
                if animal.content.isEmpty {
                    CardView(
                        content: .init(fact: "No facts about \(animal.title)...", image: ""),
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
