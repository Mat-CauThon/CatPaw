//
//  RandomCatView.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import SwiftUI
import Combine

struct RandomCatView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject public var source: CatsSource
    @State public var fillPoint = 0.0
    public let publisher = PassthroughSubject<Message,Never>()
    
    private var animation: Animation {
        Animation.linear(duration: 1).repeatForever(autoreverses: false)
    }
   
    private func buttonView(imgSystmeName: String, color: Color) -> some View {
        var view: some View {
            ZStack {
                Circle() //for avoid tap gesture lose
                .fill(colorScheme == .dark ? Color.black : Color.white)
                .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                Image(systemName: imgSystmeName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(color)
                    .shadow(color: Color(UIColor.systemGray4), radius: 2)
            }
            .padding(30)
        }
        return view
    }

    internal var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    // not switch cause it's not allowed in this place
                    if self.source.randomState == .ready {
                        ZStack {
                            ForEach(self.source.randomCats.reversed(), id: \.id) { cat in
                                CatSwipeView(cat: cat, rootView: self)
                                    .shadow(color: Color(UIColor.systemGray4), radius: 3)
                            }
                        }
                        HStack {
                            self.buttonView(imgSystmeName: "xmark.circle", color: .red)
                                .onTapGesture {
                                    self.fillPoint = 0.0
                                    self.publisher.send(.delete)
                                }
                            self.buttonView(imgSystmeName: "heart.circle", color: .green)
                                .onTapGesture {
                                    self.fillPoint = 0.0
                                    self.publisher.send(.add)
                                }
                            
                        }.frame(width: geometry.size.width, height: geometry.size.height/4)
                    } else if self.source.randomState == .loading {
                        ActivityIndicator(fillPoint: self.fillPoint)
                            .stroke(Color(UIColor.systemBlue), lineWidth: 10)
                            .frame(width: 100, height: 100)
                            .onAppear() {
                                withAnimation(self.animation) {
                                    self.fillPoint = 1.0
                                }
                            }
                    } else if self.source.randomState == .failed {
                        Text("Refresh")
                            .foregroundColor(Color(UIColor.systemBlue))
                        .onTapGesture {
                                self.source.randomState = .loading
                                self.fillPoint = 0.0
                                self.publisher.send(.load)
                        }
                    }
                }
            }
                .navigationBarTitle("CatPaw", displayMode: .large)
        }
            .navigationViewStyle(StackNavigationViewStyle())
    }
    
}
