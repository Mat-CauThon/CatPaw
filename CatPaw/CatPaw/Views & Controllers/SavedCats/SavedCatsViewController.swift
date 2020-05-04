//
//  SavedCatsViewController.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class SavedCatsViewController: UIHostingController<SavedCatsView>, UIViewControllerDelegate {
    
    var queryItems: [URLQueryItem] = []
    
    
    
    private var catsToken: Cancellable?
    
    override init(rootView: SavedCatsView) {
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCommunication() {
        catsToken = rootView.publisher.sink { [weak self] message in
            
        }
    }
    
    func alarm(message: String) {
        self.presentAlert(with: message)
    }
    
}
