//
//  ProductCellView.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct ProductCellView: View {
    
    let animal: Animal
    
    var body: some View {
        HStack(alignment: .top) {
            if let im = UIImage(data: animal.image) {
                ZStack {
                    Image(uiImage: im)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: UIScreen.main.bounds.width / 2.5,
                               maxHeight: UIScreen.main.bounds.width / 3.5)
                        .background(Color.gray)
                        .padding(8)
                    
                }
            } else {
                Image("Bitmap")
            }
            VStack(alignment: .leading) {
                animalTitle
                animalDescription
                
                statusView(for: .paid)
                    .padding([.top])
                
            }
            .padding([.top], 4)
            Spacer()
            statusView(for: .comingSoon)
        }
        .overlay(animal.status == .comingSoon ? Color.black.opacity(0.6) : Color.clear)
    }
    
    struct StatusView: View {
        let imageName: String
        let statusText: String
        let statusColor: Color
        
        var body: some View {
            HStack {
                Image(imageName)
                Text(statusText)
                    .foregroundColor(Color(red: 8/255, green: 58/255, blue: 235/255))

            }
        }
    }
    
    @ViewBuilder
    private func statusView(for status: ProductState) -> some View {
        if animal.status == status {
            switch status {
            case .paid:
                StatusView(
                    imageName: "Shape",
                    statusText: "Premium",
                    statusColor: Color("083AEB"))
            case .comingSoon:
                StatusView(
                    imageName: "coming-soon 1",
                    statusText: "",
                    statusColor: .clear)
            default:
                EmptyView()
            }
        } else {
            EmptyView()
        }
    }
    
    private var animalTitle: some View {
        Text(animal.title)
            .font(.headline)
            .foregroundColor(.black)
    }
    
    private var animalDescription: some View {
        Text(animal.description)
            .font(.subheadline)
            .foregroundColor(.gray)
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(animal: .init(
            title: "Title",
            description: "Description",
            image: Data(),
            order: 1,
            status: .comingSoon,
            content: [])
        )
    }
}
