//
//  ProductCellView.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import SwiftUI

struct AnimalCategoriesCellView: View {
    
    let animal: Animal
    
    var body: some View {
        HStack(alignment: .top) {
            if let im = UIImage(data: animal.image) {
                ZStack {
                    Image(uiImage: im)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width / 2.5,
                               height: UIScreen.main.bounds.width / 3.8)
                        .background(Color.gray)
                        .padding(8)
                }
            } else {
                Image("Bitmap")
            }
            VStack(alignment: .leading) {
                animalTitle
                animalDescription
                Spacer()
                statusView(for: .paid)
                    .padding([.bottom], 8)
            }
            .padding([.top], 4)
            Spacer()
            statusView(for: .comingSoon)
                .padding([.vertical])
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
            .lineLimit(1)
    }
    
    private var animalDescription: some View {
        Text(animal.description)
            .font(.subheadline)
            .foregroundColor(.gray)
            .lineLimit(2)
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalCategoriesCellView(animal: .init(
            title: "Title",
            description: "Description",
            image: Data(),
            order: 1,
            status: .paid,
            content: [])
        )
    }
}
