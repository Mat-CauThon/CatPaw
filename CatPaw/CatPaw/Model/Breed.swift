//
//  Breed.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 22.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation

final class Breed {
    var adaptability: Int
    var affectionLevel: Int
    var dogFriendly: Int
    var energyLevel: Int
    var grooming: Int
    var hairless: Int
    var desc: String
    var hypoallergenic: Int
    var name: String
    var temperament: [String]
    var rare: Int
    
    init(adaptability: Int, affectionLevel: Int, dogFriendly: Int, energyLevel: Int, grooming: Int, hairless: Int, desc: String, hypoallergenic: Int, name: String, temperament: [String], rare: Int) {
        self.adaptability = adaptability
        self.affectionLevel = affectionLevel
        self.dogFriendly = dogFriendly
        self.energyLevel = energyLevel
        self.grooming = grooming
        self.hairless = hairless
        self.desc = desc
        self.hypoallergenic = hypoallergenic
        self.name = name
        self.temperament = temperament
        self.rare = rare
    }
    
}
