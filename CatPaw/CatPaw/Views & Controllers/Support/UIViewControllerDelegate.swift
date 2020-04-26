//
//  UIVIewControllerDelegate.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation

// used for error alarm in Networking or CoreData
protocol UIViewControllerDelegate {
    func alarm(message: String)
}
