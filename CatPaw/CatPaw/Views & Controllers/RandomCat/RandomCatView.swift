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
    
    @ObservedObject var source: CatsSource
    @State var fillPoint = 0.0
    public let publisher = PassthroughSubject<Void,Never>()
    
    private var animation: Animation {
        Animation.linear(duration: 1).repeatForever(autoreverses: false)
    }

    var body: some View {
        VStack{
            // not switch cause it's not allowed in this place
            if source.randomState == .ready {
                Image(uiImage: source.randomCat!.image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .padding(10)
                
                HStack {
                    Button(action: {
                        self.fillPoint = 0.0
                        self.publisher.send()
                    }) {
                        Text("Discard")
                    }
                    Spacer()
                    Button(action: {
                        self.source.save()
                        self.fillPoint = 0.0
                        self.publisher.send()
                    }) {
                        Text("Like")
                    }
                }
                .padding(30)
                
                
            } else if source.randomState == .loading {
                ActivityIndicator(fillPoint: fillPoint)
                    .stroke(Color.blue, lineWidth: 10)
                    .frame(width: 100, height: 100)
                    .onAppear(){
                        withAnimation(self.animation) {
                            self.fillPoint = 1.0
                        }
                    }
            } else if source.randomState == .failed {
                Button(action: {
                    self.source.randomState = .loading
                    self.fillPoint = 0.0
                    self.publisher.send()
                }) {
                    Text("Refresh")
                }
            }
        }
    }
}
