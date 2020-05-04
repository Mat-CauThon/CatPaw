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
    
    var queryItems: [URLQueryItem] = [URLQueryItem(name: "limit", value: "1"), URLQueryItem(name: "page", value: "1"), URLQueryItem(name: "mime_types", value: "jpg")]
    private var catsToken: Cancellable?
    private var loadBreedToken: Cancellable?
    private var network: Networking?
    
    func alarm(message: String) {
        self.presentAlert(with: message)
    }
    
    override init(rootView: ListOfCatsView) {
        super.init(rootView: rootView)
        network = Networking(delegate: self)
        configureCommunication()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCat() {
        network?.loadCats(items: queryItems){ [weak self] randomCat in
            DispatchQueue.main.async {
                if let newCat = randomCat {
                    self?.rootView.source.cats.append(newCat)
//                    self?.rootView.source.cats.sort(by: { (first, second) -> Bool in
//                        return first.breeds.last!.name < second.breeds.last!.name
//                    })
                    self?.rootView.source.breedState[(self?.rootView.source.cats.count)!-1] = .ready
                }
            }
        }
    }
    
    func getBreeds() {
    
        network?.loadBreeds { [weak self] breedList in
            DispatchQueue.main.async {
                if let safeBreeds = breedList {
                    self?.rootView.source.breeds = safeBreeds
                    for i in 0..<safeBreeds.count {
                        self?.rootView.source.breedState.append(.loading)
                        self?.queryItems.append(URLQueryItem(name: "breed_id", value: safeBreeds[i].id))
                        self?.getCat()
                        self?.queryItems.removeLast()
                    }
                }
            }
        }
    
    }
    
    
    func configureCommunication() {
        catsToken = rootView.publisher.sink { [weak self] message in
            switch message {
                case .load:
                    self?.getBreeds()
                case .sort:
                    self?.sortCats()
                case .delete:
                    print("Delete in list (error in messages)")
                case .add:
                    print("Add in list (error in messages)")
                case .none :
                print("Nothing there")
            }
            
        }
    }
    
    func sortCats() {
        let currentRaw = (self.rootView.source.catsSortedIndex + 1) % self.rootView.items.count
        let currentIndex = SortIdentifier(rawValue: currentRaw)
        self.rootView.source.catsSortedIndex = currentRaw
        
        self.rootView.source.cats.sort { (first, second) -> Bool in
            switch currentIndex {
            case .Alphabet:
                return first.breeds.last!.name < second.breeds.last!.name
            case .Adaptability:
                return first.breeds.last!.adaptability > second.breeds.last!.adaptability
            case .Rare:
                return first.breeds.last!.rare > second.breeds.last!.rare
            case .Intelligence:
                return first.breeds.last!.intelligence > second.breeds.last!.intelligence
            case .Grooming:
                return first.breeds.last!.grooming > second.breeds.last!.grooming
            case .Hairless:
                return first.breeds.last!.hairless > second.breeds.last!.hairless
            case .Vocalisation:
                return first.breeds.last!.vocalisation > second.breeds.last!.vocalisation
            case .Hypoallergenic:
                return first.breeds.last!.hypoallergenic > second.breeds.last!.hypoallergenic
            case .none:
                print("Some error")
                return true
            }
        }

    }
    
    
}
