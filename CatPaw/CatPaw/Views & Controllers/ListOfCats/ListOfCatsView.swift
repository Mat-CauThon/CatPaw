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
    let publisher = PassthroughSubject<Void,Never>()
    
    var body: some View {
        Text("ListOfCatsView")
    }
}
