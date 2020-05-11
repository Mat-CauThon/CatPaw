//
//  File.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 25.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import SwiftUI

// used for indicate loading from network in RandomCatView
struct ActivityIndicator: Shape {
    
    public var fillPoint: Double
    public var delayPoint: Double = 0.5
    public var animatableData: Double {
        get {return fillPoint}
        set {fillPoint = newValue}
    }
    
    public func path(in rect: CGRect) -> Path {
        var start: Double = 0
        let end: Double = 360 * fillPoint
        if fillPoint > delayPoint {
            start = (2 * fillPoint) * 360
        } else {
            start = 0
        }
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.width/2, y: rect.height/2),
            radius: rect.width/2,
            startAngle: .degrees(start),
            endAngle: .degrees(end),
            clockwise: false)
        return path
    }
    
}
