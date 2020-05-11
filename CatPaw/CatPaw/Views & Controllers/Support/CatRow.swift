//
//  CatRow.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 02.05.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import SwiftUI

struct CatRow: View {
    
    @Environment(\.colorScheme) private var colorScheme
    internal var cat: CatClass
    
    internal var body: some View {
        ZStack(alignment: .topLeading) {
            Image(uiImage: cat.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(cat.breeds.last?.name ?? "Unknown breed")
            .bold()
            .padding(5)
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
    }
    
}
