//
//  BreedDetail.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 07.05.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import SwiftUI

struct BreedDetailView: View {
    
    public var breedCat: CatClass
    public var breed: Breed
    
    private func parameter(text: String, value: Int) -> some View {
        var view: some View {
            HStack {
                Text(text+":")
                Spacer()
                ForEach(0..<value) {_ in
                    Image("paw")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(UIColor.systemBlue))
                }
            }.padding()
        }
        return view
    }
    
    internal var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: breedCat.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
                Text(breed.temperament.capitalized)
                    .bold()
                    .padding(.horizontal)
                Text(breed.desc)
                    .padding()
                parameter(text: "Adaptability", value: breed.adaptability)
                parameter(text: "Rare", value: breed.rare)
                parameter(text: "Intelligence", value: breed.intelligence)
                parameter(text: "Hypoallergenic", value: breed.hypoallergenic)
                parameter(text: "Vocalisation", value: breed.vocalisation)
                parameter(text: "Grooming", value: breed.grooming)
                parameter(text: "Hairless", value: breed.hairless)
            }
        }
        .navigationBarTitle(Text(breed.name), displayMode: .inline)
    }
    
}
