//
//  SavedCatsView.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import SwiftUI
import Combine
struct SavedCatsView: View {
    
    @ObservedObject var source: CatsSource
    let publisher = PassthroughSubject<Message,Never>()
    
    
    var body: some View {
        List {
            ForEach(source.savedCats, id: \.id) { cat in
                
                VStack {
                    Text(cat.breeds.last?.name ?? "Unknown breed")
                    Image(uiImage: cat.image)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                }   
            }
        }
    }
}
