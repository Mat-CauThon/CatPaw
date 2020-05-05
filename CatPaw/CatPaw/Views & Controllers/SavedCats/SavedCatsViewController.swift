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
    private var database: Database?
    
    override init(rootView: SavedCatsView) {
        super.init(rootView: rootView)
        database = Database()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCommunication() {
        catsToken = rootView.publisher.sink { [weak self] message in
            
        }
    }
    
    public func load() {
        if let result = self.database?.loadLikedCats() {
            self.rootView.source.savedCats = result
        }
    }
    
    public func alarm(message: String) {
        self.presentAlert(with: message)
    }
    
}
