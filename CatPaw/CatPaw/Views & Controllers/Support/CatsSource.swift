//
//  CatsSource.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import SwiftUI

final class CatsSource: ObservableObject {
    
    enum LoadingState {
        case loading
        case ready
        case failed
    }
    
    @Published public var randomCats: [CatClass] = []
    @Published public var cats: [CatClass] = []
    @Published public var savedCats: [CatClass] = []
    @Published public var catsSortedIndex: Int = 0
    @Published public var breedState: [LoadingState] = []
    @Published public var isHideBar = true
    @Published public var randomState = LoadingState.loading
    @Published public var recognizeImage: UIImage?
    @Published public var recognizeResult: String = ""
    @Published public var recognizeResultColor = UIColor.systemBackground
    
    public func save() -> CatClass? {
        if let catForSave = randomCats.first {
            catForSave.liked = true
            savedCats.append(catForSave)
            return catForSave
        }
        return nil
    }
    
}
