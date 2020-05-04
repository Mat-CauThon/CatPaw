//
//  CatSwipeView.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 04.05.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation
import SwiftUI

struct CatSwipeView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var translation: CGSize = .zero
    var thresholdPercentage: CGFloat = 0.5 // when the user has draged 50% the width of the screen in either direction
    var cat: CatClass
    var rootView: RandomCatView
    @State var message = Message.add
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                Image(uiImage: self.cat.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
            }
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geo.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged{ (value) in
                        self.translation = value.translation
                        
                        if (self.getGesturePercentage(geo, from: value)) >= self.thresholdPercentage {
                            self.message = .add
                        } else if self.getGesturePercentage(geo, from: value) <= -self.thresholdPercentage {
                            self.message = .delete
                        } else {
                            self.message = .none
                        }
                    }
                    .onEnded{ (value) in
                        if abs(self.getGesturePercentage(geo, from: value)) > self.thresholdPercentage {
                            self.rootView.fillPoint = 0.0
                            self.rootView.publisher.send(self.message)
                            
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
        
    }
}
