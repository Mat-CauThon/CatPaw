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
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var source: CatsSource
    @State var fillPoint = 0.0
    public let publisher = PassthroughSubject<Message,Never>()
   
    
    private var animation: Animation {
        Animation.linear(duration: 1).repeatForever(autoreverses: false)
    }
    
    
    
    private func buttonView(imgSystmeName: String, color: Color) -> some View {
        var view: some View {
            ZStack {
                Circle()
                    .fill(color)
                Image(systemName: imgSystmeName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(30)
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
            }
            .padding(30)
        }
        return view
    }

    var body: some View {
        VStack{
            // not switch cause it's not allowed in this place
            if source.randomState == .ready {
                ZStack {
                    ForEach(self.source.randomCats.reversed(), id: \.id) { cat in
                        CatSwipeView(cat: cat, rootView: self)
                    }
                }
                HStack {
                    buttonView(imgSystmeName: "xmark", color: .red)
                        .onTapGesture {
                            self.fillPoint = 0.0
                            self.publisher.send(.delete)
                        }
                    Spacer()
                    buttonView(imgSystmeName: "heart.fill", color: .green)
                        .onTapGesture {
                            self.fillPoint = 0.0
                            self.publisher.send(.add)
                        }
                }
            } else if source.randomState == .loading {
                ActivityIndicator(fillPoint: fillPoint)
                    .stroke(Color.blue, lineWidth: 10)
                    .frame(width: 100, height: 100)
                    .onAppear() {
                        withAnimation(self.animation) {
                            self.fillPoint = 1.0
                        }
                    }
            } else if source.randomState == .failed {
                Text("Refresh")
                .onTapGesture {
                        self.source.randomState = .loading
                        self.fillPoint = 0.0
                        self.publisher.send(.load)
                }
            }
        }
    }
}
