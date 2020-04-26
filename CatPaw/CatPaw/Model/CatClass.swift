//
//  CatClass.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation
import SwiftUI

final class CatClass {
    
    public var id: String
    private var url: URL
    private var width: Int
    private var height: Int
    public var image: UIImage
    
    // important: dont call in another place or create background thread before
    init(id: String, url: URL, width: Int, height: Int) {
        self.id = id
        self.url = url
        self.width = width
        self.height = height
        self.image = UIImage(systemName: "xmark.octagon.fillrhz")!
        
        // i don't create another thread, cause CatClass init called in background thread in Networking class
        if let data = try? Data(contentsOf: url) {
            if let dImage = UIImage(data: data) {
                self.image = dImage
            }
        }
        
    }
}


