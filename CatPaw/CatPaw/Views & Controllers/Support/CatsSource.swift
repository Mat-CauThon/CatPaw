//
//  CatsSource.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation

final class CatsSource: ObservableObject {
    
    enum loadingState {
        case loading
        case ready
        case failed
    }
    
    @Published var cats: [CatClass] = []
    @Published var randomCat: CatClass?
    @Published var savedCats: [CatClass] = []
    
    @Published var catsState = loadingState.loading
    @Published var randomState = loadingState.loading
    @Published var savedState = loadingState.loading
    
    func save() {
        savedCats.append(randomCat!)
    }
    
}
