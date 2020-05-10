//
//  CatsSource.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation
import SwiftUI

final class CatsSource: ObservableObject {
    
    enum loadingState {
        case loading
        case ready
        case failed
    }
    
    @Published var breeds: [Breed] = []
    @Published var cats: [CatClass] = []
    @Published var randomCats: [CatClass] = []
    @Published var savedCats: [CatClass] = []
    @Published var catsSortedIndex: Int = 0
    @Published var breedState: [loadingState] = []
    @Published var randomState = loadingState.loading
    @Published var savedState = loadingState.loading
    
    //call it if you have at least 1 cat in randomCats
    public func save() -> CatClass? {
        if let catForSave = randomCats.first {
            catForSave.liked = true
            savedCats.append(catForSave)
            return catForSave
        }
        return nil
    }
    
}
