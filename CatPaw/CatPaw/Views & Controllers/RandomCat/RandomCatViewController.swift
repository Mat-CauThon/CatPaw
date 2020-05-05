//
//  RandomCatViewController.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class RandomCatViewController: UIHostingController<RandomCatView>, UIViewControllerDelegate {
    
    private let loadLimit = 4
    internal var queryItems: [URLQueryItem] = [URLQueryItem(name: "page", value: "1"), URLQueryItem(name: "mime_types", value: "jpg"),URLQueryItem(name: "limit", value: "4")]
    private var randomToken: Cancellable?
    private var network: Networking?
    private var database: Database?
    
    public func alarm(message: String) {
        self.presentAlert(with: message)
        self.rootView.source.randomState = .failed
    }

    override init(rootView: RandomCatView) {
        super.init(rootView: rootView)
        database = Database()
        network = Networking(delegate: self)
        configureCommunication()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getCat() {
        if loadLimit - self.rootView.source.randomCats.count > 0 {
            queryItems.removeLast()
            queryItems.append(URLQueryItem(name: "limit", value: String(loadLimit - self.rootView.source.randomCats.count)))
            network?.loadCats(items: queryItems){ [weak self] randomCat in
                DispatchQueue.main.async {
                    if let newCat = randomCat {
                        self?.rootView.source.randomCats.append(newCat)
                        if self!.rootView.source.randomCats.count >= self!.loadLimit {
                            self?.rootView.source.randomState = .ready
                        }
                    }
                }
            }
        }
    }
    
    private func getSubCat() {
        self.rootView.source.randomCats.removeFirst()
        if self.rootView.source.randomCats.count < 1 {
            self.rootView.source.randomState = .loading
        }
        getCat()
    }
    
    private func configureCommunication() {
        randomToken = rootView.publisher.sink { [weak self] message in
            switch message {
                case .load:
                    self?.rootView.source.randomState = .loading
                    self?.getCat()
                case .add:
                    if let saved = self?.rootView.source.save() {
                        self?.database?.saveCat(cat: saved)
                    }
                    self?.getSubCat()
                case .delete:
                    self?.getSubCat()
                case .sort:
                    print("Sort in random (error in messages)")
                case .none:
                    print("Nothing there")
            }
        }
    }
    
}


