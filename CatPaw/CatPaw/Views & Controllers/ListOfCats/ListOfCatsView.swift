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
        if source.breedState.count == 0 {
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if checkBreedsState() {
                    HStack {
                        HStack {
                            Image(systemName: "line.horizontal.3.decrease")
                            Text(items[source.catsSortedIndex])
                            
                        }.onTapGesture {
                            self.publisher.send(.sort)
                        }
                            .foregroundColor(.blue)
                            .scaledToFit()
                            .padding(20)
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "arrow.clockwise")
                        }.onTapGesture {
                            self.publisher.send(.delete)
                        }
                            .foregroundColor(.blue)
                            .scaledToFit()
                            .padding(20)
                    }
                }
                List {
                    ForEach(source.cats, id: \.id) { cat in
                        ZStack {
                            CatRow(cat: cat)
                            NavigationLink(destination: BreedDetailView(breedCat: cat, breed: cat.breeds.first!)) { //.buttonStyle(PlainButtonStyle()) doesn't work, but this example does
                                EmptyView()
                            }.frame(width: 0)
                        }
                    }
                        .cornerRadius(20)
                        .shadow(color: Color(UIColor.systemGray4), radius: 5)
                }
                
            }.navigationBarTitle("Breeds")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
}
