//
//  AsyncImageLoader.swift
//  Promova-iOS
//
//  Created by antonhoang on 22/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI
import Combine

struct AsyncImageLoader: View {
    @StateObject private var imageLoader: ImageLoader
    @State private var isImageLoaded = false

    init(id: UUID, imageData: Data) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(id: id, imageData: imageData))
    }

    var body: some View {
        ZStack {
            imageLoader.image?
                .resizable()
                .scaledToFit()
                .opacity(isImageLoaded ? 1 : 0)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        isImageLoaded = true
                    }
                }
            ProgressView()
                .opacity(isImageLoaded ? 0 : 1)
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: Image?
    private let imageData: Data
    private var cancellable: AnyCancellable?

    private(set) static var imageCache = [UUID: Image]()

    init(id: UUID, imageData: Data) {
        self.imageData = imageData
        if let cachedImage = ImageLoader.imageCache[id] {
            self.image = cachedImage
        } else {
            let placeholderImage = Image("Bitmap")
            self.image = placeholderImage
            loadImage(with: id)
        }
    }

    private func loadImage(with id: UUID) {
        cancellable = Just(imageData)
            .compactMap { UIImage(data: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] uiImage in
                self?.image = Image(uiImage: uiImage)
                ImageLoader.imageCache[id] = self?.image
            })
    }
}
