//
//  CodableBreed.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 26.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation

final class CodableBreed: Codable {
    
    private var id: String
    private var intelligence: Int
    private var adaptability: Int
    private var vocalisation: Int
    private var grooming: Int
    private var hairless: Int
    private var desc: String
    private var hypoallergenic: Int
    private var name: String
    private var temperament: String
    private var rare: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case intelligence
        case adaptability
        case vocalisation
        case grooming
        case hairless
        case desc = "description"
        case hypoallergenic
        case name
        case temperament
        case rare
    }
    
    public func retBreed() -> Breed {
        return Breed(id: id, adaptability: adaptability, intelligence: intelligence, vocalisation: vocalisation, grooming: grooming, hairless: hairless, desc: desc, hypoallergenic: hypoallergenic, name: name, temperament: temperament, rare: rare)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(intelligence, forKey: .intelligence)
        try container.encode(vocalisation, forKey: .vocalisation)
        try container.encode(adaptability, forKey: .adaptability)
        try container.encode(grooming, forKey: .grooming)
        try container.encode(hairless, forKey: .hairless)
        try container.encode(desc, forKey: .desc)
        try container.encode(hypoallergenic, forKey: .hypoallergenic)
        try container.encode(name, forKey: .name)
        try container.encode(temperament, forKey: .temperament)
        try container.encode(rare, forKey: .rare)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        intelligence = try container.decode(Int.self, forKey: .intelligence)
        vocalisation = try container.decode(Int.self, forKey: .vocalisation)
        adaptability = try container.decode(Int.self, forKey: .adaptability)
        grooming = try container.decode(Int.self, forKey: .grooming)
        hairless = try container.decode(Int.self, forKey: .hairless)
        desc = try container.decode(String.self, forKey: .desc)
        hypoallergenic = try container.decode(Int.self, forKey: .hypoallergenic)
        name = try container.decode(String.self, forKey: .name)
        temperament = try container.decode(String.self, forKey: .temperament)
        rare = try container.decode(Int.self, forKey: .rare)
    }
    
}
