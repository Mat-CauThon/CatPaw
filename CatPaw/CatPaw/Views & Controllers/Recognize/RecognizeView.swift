//
//  RecognizeView.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import SwiftUI
import Combine

struct RecognizeView: View {
    
    @ObservedObject public var source: CatsSource
    @Environment(\.colorScheme) private var colorScheme
    public let publisher = PassthroughSubject<Void,Never>()
    
    internal var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    ZStack {
                        ZStack(alignment: .bottom) {
                            if self.source.recognizeImage != nil {
                                Image(uiImage: self.source.recognizeImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(20)
                                .padding(10)
                            } else {
                                Image(systemName: "camera.viewfinder")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(20)
                                .foregroundColor(Color(UIColor.systemBlue))
                                .padding(10)
                            }
                        }
                    }.onTapGesture {
                        self.publisher.send()
                    }
                    Text(self.source.recognizeResult.uppercased())
                        .bold()
                        .font(.title)
                        .foregroundColor(Color(self.source.recognizeResultColor))
                    Spacer()
                    Spacer()
                }
            }
            .navigationBarTitle("Cat Recognizer", displayMode: .large)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
}

