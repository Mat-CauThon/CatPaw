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
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var source: CatsSource
    let publisher = PassthroughSubject<IndexSet,Never>()
    func delete(at offsets: IndexSet) {
        publisher.send(offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(source.savedCats, id: \.id) { cat in
                    CatRow(cat: cat)
                }
                .onDelete(perform: delete)
//                .background(colorScheme == .dark ? Color.black : Color.white)
                .cornerRadius(20)
                .shadow(color: Color(UIColor.systemGray4), radius: 5)
            }.navigationBarTitle("Liked")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
