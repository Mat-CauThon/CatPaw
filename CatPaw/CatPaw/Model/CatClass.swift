//
//  CatClass.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import SwiftUI

final class CatClass: Identifiable {
    
    public var id: String
    public var image: UIImage
    public var breeds: [Breed]
    public var liked = false

    init(id: String, breeds: [Breed], image: UIImage) {
        self.id = id
        self.image = image
        self.breeds = breeds
    }
    
}


