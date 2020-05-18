//
//  Breed.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 22.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation

final class Breed {
    
    public var id: String
    public var adaptability: Int
    public var intelligence: Int
    public var vocalisation: Int
    public var grooming: Int
    public var hairless: Int
    public var desc: String
    public var hypoallergenic: Int
    public var name: String
    public var temperament: String
    public var rare: Int
    
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
