//
//  CatRow.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 02.05.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation
import SwiftUI

struct CatRow: View {
    
    @Environment(\.colorScheme) var colorScheme
    var cat: CatClass
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(uiImage: cat.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(cat.breeds.last?.name ?? "Unknown breed")
            .bold()
            .padding(5)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
    }
    
}
