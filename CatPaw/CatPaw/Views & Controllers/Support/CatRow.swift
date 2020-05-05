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
    var cat: CatClass
    var body: some View {
        VStack {
            HStack {
                Text(cat.breeds.last?.name ?? "Unknown breed")
                    .bold()
                Spacer()
            }
            Image(uiImage: cat.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        
    }
    
}
