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
    
    
    private var randomToken: Cancellable?
    private var network: Networking?
    private var oldCat: CatClass?
    
    func alarm(message: String) {
        self.presentAlert(with: message)
        self.rootView.source.randomState = .failed
    }
    
    override init(rootView: RandomCatView) {
        super.init(rootView: rootView)
        network = Networking(url: "https://api.thecatapi.com/v1/images/search", delegate: self, limit: 1)
        configureCommunication()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getCat() {
        network?.loadCats{ [weak self] randomCat in
            DispatchQueue.main.async {
                if let newCat = randomCat {
                    self?.oldCat = newCat
                    self?.rootView.source.randomCat = newCat
                    self?.rootView.source.randomState = .ready
                }
            }
            
        }
    }
    
    func configureCommunication() {
        randomToken = rootView.publisher.sink { [weak self] in
            self?.rootView.source.randomState = .loading
            self?.getCat()
        }
    }
}
