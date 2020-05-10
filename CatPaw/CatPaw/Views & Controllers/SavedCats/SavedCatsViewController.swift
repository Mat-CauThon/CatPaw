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

final class SavedCatsViewController: UIHostingController<SavedCatsView> {
    
    private var catsToken: Cancellable?
    private var database: Database?
    
    override init(rootView: SavedCatsView) {
        super.init(rootView: rootView)
        database = Database()
        configureCommunication()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCommunication() {
        catsToken = rootView.publisher.sink { [weak self] messageID in
            for index in messageID.enumerated() {
                self?.database?.removeCat(id: self?.rootView.source.savedCats[index.element].id ?? "")
            }
            self?.rootView.source.savedCats.remove(atOffsets: messageID)
        }
    }
    
    public func load() {
        if let result = self.database?.loadLikedCats() {
            self.rootView.source.savedCats = result
        }
    }
    
}
