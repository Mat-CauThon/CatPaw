//
//  File.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 10.05.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import UIKit

public protocol ImagePickerDelegate: class {
    
    func didSelect(image: UIImage?)
    
}
