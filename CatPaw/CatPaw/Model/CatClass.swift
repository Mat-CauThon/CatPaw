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
    public var image: UIImage
    public var breeds: [Breed]
    public var liked = false
    // important: be careful when call without background thread
    init(id: String, url: URL?, breeds: [Breed], image: Data?) {
        self.id = id
        self.image = UIImage(systemName: "xmark.circle.fill")!
        self.breeds = breeds
        
        
        if let img = image { // load from database
            self.image = UIImage(data: img) ?? UIImage(systemName: "xmark.circle.fill")!
        } else { // load from web in background thread from Networking class
            if let safeUrl = url {
                if let data = try? Data(contentsOf: safeUrl) {
                    if let dImage = UIImage(data: data) {
                        self.image = dImage
                    }
                }
            }
        }
    }
}


