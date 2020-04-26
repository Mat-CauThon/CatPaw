//
//  ListOfCats.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class ListOfCatsViewController: UIHostingController<ListOfCatsView>, UIViewControllerDelegate {
    
    private var catsToken: Cancellable?
    private var network: Networking?
    
    func alarm(message: String) {
        self.presentAlert(with: message)
    }
    
    override init(rootView: ListOfCatsView) {
        super.init(rootView: rootView)
        network = Networking(url: "", delegate: self, limit: 50)
        configureCommunication()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getCat() {
        
        network?.loadCats{ [weak self] randomCat in
            
            DispatchQueue.main.async {
                if let newCat = randomCat {
                    self?.rootView.source.cats.append(newCat)
                }
            }
            
        }
    }
    
    func configureCommunication() {
        catsToken = rootView.publisher.sink { [weak self] in
            
            self?.getCat()
            
        }
    }
    
    
}
