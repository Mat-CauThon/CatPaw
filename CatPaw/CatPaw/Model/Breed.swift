//
//  Breed.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 22.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation

final class Breed {
    
    var id: String
    var adaptability: Int
    var intelligence: Int
    var vocalisation: Int
    var grooming: Int
    var hairless: Int
    var desc: String
    var hypoallergenic: Int
    var name: String
    var temperament: String
    var rare: Int
    
    init(id: String, adaptability: Int, intelligence: Int, vocalisation: Int, grooming: Int, hairless: Int, desc: String, hypoallergenic: Int, name: String, temperament: String, rare: Int) {
        self.id = id
        self.adaptability = adaptability
        self.intelligence = intelligence
        self.vocalisation = vocalisation
        self.grooming = grooming
        self.hairless = hairless
        self.desc = desc
        self.hypoallergenic = hypoallergenic
        self.name = name
        self.temperament = temperament
        self.rare = rare
    }
    
}
