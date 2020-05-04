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
    
    public func save() {
        print(savedCats)
        savedCats.append(randomCats.first!)
    }
    
    public func update(id: String, value: CGFloat, degree: Double) {
        for i in 0..<randomCats.count {
            
            if randomCats[i].id == id {
                print("id = \(id)")
                randomCats[i].drag = value
                randomCats[i].degree = degree
            }
        }
    }
    
    
    
}
