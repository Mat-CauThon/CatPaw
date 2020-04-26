//
//  CodableCatClass.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 25.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation

final class CodableCatClass: Codable {
    
    var id: String
    var url: URL
    var width: Int
    var height: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case width
        case height
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        url = try container.decode(URL.self, forKey: .url)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        
    }
    
    
}