//
//  ListOfCatsView.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import SwiftUI
import Combine

struct ListOfCatsView: View {
    
    @ObservedObject var source: CatsSource
    let publisher = PassthroughSubject<Message,Never>()
    var items = ["Alphabet","Adaptability","Rare","Intelligence","Grooming","Hairless","Vocalisation","Hypoallergenic"]
    
    func checkBreedsState() -> Bool {
        for item in source.breedState {
            if item != .ready {
                return false
            }
        }
        return true
    }
    
    var body: some View {
        
        VStack {
            
            if checkBreedsState() {
                HStack {
                    Spacer()
                    Button(action: {
                        self.publisher.send(.sort)
                    }) {
                        HStack {
                            Image(systemName: "line.horizontal.3.decrease.circle.fill")
                            Text(items[source.catsSortedIndex])
                        }
                    }
                    .scaledToFit()
                    .padding(20)
                }
            }
            List {
                ForEach(source.cats, id: \.id) { cat in
                    CatRow(cat: cat)
                }
            }
        }
    }
    
}
