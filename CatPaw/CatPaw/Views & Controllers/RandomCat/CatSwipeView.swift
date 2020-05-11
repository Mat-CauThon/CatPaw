//
//  CatSwipeView.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 04.05.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import SwiftUI

struct CatSwipeView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var translation: CGSize = .zero
    internal var thresholdPercentage: CGFloat = 0.35 // limit of swipe width (35%)
    internal var cat: CatClass
    internal var rootView: RandomCatView
    @State private var message = Message.none
    @State private var liked = ""
    @State private var color = Color(UIColor.systemGray6)
    @State private var borderWidth: CGFloat = 0.0
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    internal var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .foregroundColor(self.colorScheme == .dark ? Color.black : Color.white)
                    .cornerRadius(20)
                VStack {
                    Spacer()
                    Text(self.liked)
                    .foregroundColor(self.color)
                    .padding()
                    .border(self.color, width: self.borderWidth)
                    Image(uiImage: self.cat.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .padding(10)
                    Spacer()
                }
            }
                .animation(.interactiveSpring())
                .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geo.size.width) * 25), anchor: .top)
                .gesture(
                    DragGesture()
                        .onChanged{ (value) in
                            self.translation = value.translation
                            if (self.getGesturePercentage(geo, from: value)) >= self.thresholdPercentage {
                                self.liked = "LIKE"
                                self.color = Color(UIColor.systemGreen)
                                self.borderWidth = 5
                                self.message = .add
                            } else if self.getGesturePercentage(geo, from: value) <= -self.thresholdPercentage {
                                self.liked = "NOPE"
                                self.color = Color(UIColor.systemRed)
                                self.borderWidth = 5
                                self.message = .delete
                            } else {
                                self.liked = ""
                                self.color = self.colorScheme == .dark ? Color.black : Color.white
                                self.borderWidth = 0
                                self.message = .none
                            }
                        }
                        .onEnded{ (value) in
                            self.liked = ""
                            self.color = self.colorScheme == .dark ? Color.black : Color.white
                            self.borderWidth = 0
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
