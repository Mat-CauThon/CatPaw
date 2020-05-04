//
//  CatClass.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation
import SwiftUI

final class CatClass: Identifiable {
    
    public var id: String
    private var url: URL
    private var width: Int
    private var height: Int
    public var image: UIImage
    public var breeds: [Breed]
    
    public var drag : CGFloat = 0.0
    public var degree : Double = 0.0
    
    // important: dont call in another place or create background thread before
    init(id: String, url: URL, width: Int, height: Int, breeds: [Breed]) {
        self.id = id
        self.url = url
        self.width = width
        self.height = height
        self.image = UIImage(systemName: "xmark.octagon.fill")!
        self.breeds = breeds
        
        // i don't create another thread, cause CatClass init called in background thread in Networking class
        if let data = try? Data(contentsOf: url) {
            if let dImage = UIImage(data: data) {
                self.image = dImage
            }
        }
        
    }
}


