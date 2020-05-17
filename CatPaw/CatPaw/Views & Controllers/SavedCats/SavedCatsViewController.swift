//
//  SavedCatsViewController.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import SwiftUI
import Combine

final class SavedCatsViewController: UIHostingController<SavedCatsView> {
    
    private var catsToken: Cancellable?
    private var shareToken: Cancellable?
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
        shareToken = rootView.sharePublisher.sink(receiveValue: { [weak self] image in
            let shareImage = [image]
            let activityViewController = UIActivityViewController(activityItems: shareImage, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = UIView() // so that iPads won't crash
            self?.present(activityViewController, animated: true)
        })
    }
    
    public func load() {
        if let result = self.database?.loadLikedCats() {
            self.rootView.source.savedCats = result
        }
    }
    
}
