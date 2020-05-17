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
    
    @ObservedObject public var source: CatsSource
    public let publisher = PassthroughSubject<Message,Never>()
    public var items = ["Alphabet","Adaptability","Rare","Intelligence","Grooming","Hairless","Vocalisation","Hypoallergenic"]
    
    internal var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(source.cats, id: \.id) { cat in
                        ZStack {
                            CatRow(cat: cat)
                            if !self.source.isHideBar {
                                NavigationLink(destination: BreedDetailView(breedCat: cat, breed: cat.breeds.first!)) { //.buttonStyle(PlainButtonStyle()) doesn't work, but this example does
                                    EmptyView()
                                }.frame(width: 0)
                            }
                        }
                    }
                        .cornerRadius(20)
                        .shadow(color: Color(UIColor.systemGray4), radius: 5)
                }
                
            }
                .navigationBarHidden(source.isHideBar)
                .navigationBarTitle("Breeds")
                .navigationBarItems(
                    leading:
                        HStack {
                            HStack(alignment: .firstTextBaseline) {
                                Image(systemName: "line.horizontal.3.decrease")
                                Text(items[source.catsSortedIndex])
                                Spacer()
                            }.onTapGesture {
                                self.publisher.send(.sort)
                            }
                                .foregroundColor(.blue)
                                .scaledToFit()
                            Spacer()
                        },
                    trailing:
                        HStack {
                            Image(systemName: "arrow.clockwise")
                        }.onTapGesture {
                            self.source.isHideBar = true
                            self.publisher.send(.delete)
                        }
                            .foregroundColor(.blue)
                            .scaledToFit()
                )
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
}
