//
//  UIVIewControllerDelegate.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation

// used for Networking
public protocol UIViewControllerDelegate {
    
    func alarm(message: String)
    func afterFailed()
    var queryItems: [URLQueryItem] {get set}
    
}
