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
    
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject public var source: CatsSource
    public let publisher = PassthroughSubject<IndexSet,Never>()
    public let sharePublisher = PassthroughSubject<UIImage,Never>()
    
    private func delete(at offsets: IndexSet) {
        publisher.send(offsets)
    }
    
    internal var body: some View {
        NavigationView {
            List {
                ForEach(source.savedCats, id: \.id) { cat in
                    CatRow(cat: cat).onTapGesture {
                        self.sharePublisher.send(cat.image)
                    }
                }
                .onDelete(perform: delete)
                .cornerRadius(20)
                .shadow(color: Color(UIColor.systemGray4), radius: 5)
            }.navigationBarTitle("Liked")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
