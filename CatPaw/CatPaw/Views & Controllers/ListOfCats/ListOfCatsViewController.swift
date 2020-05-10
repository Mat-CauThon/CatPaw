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
    
    internal var queryItems: [URLQueryItem] = [URLQueryItem(name: "limit", value: "1"), URLQueryItem(name: "page", value: "1"), URLQueryItem(name: "mime_types", value: "jpg")]
    private var catsToken: Cancellable?
    private var loadBreedToken: Cancellable?
    private var network: Networking?
    private var database: Database?
    
    override init(rootView: ListOfCatsView) {
        super.init(rootView: rootView)
        database = Database()
        network = Networking(delegate: self)
        configureCommunication()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func alarm(message: String) {
        self.presentAlert(with: message)
    }
    
    func afterFailed() {
        let breeds = self.database?.loadBreeds()
        if let safeBreeds = breeds{
            for breed in safeBreeds {
                if let cat = self.database?.loadCatForBreed(breedId: breed.id) {
                    self.rootView.source.cats.append(cat)
                    self.rootView.source.breedState.append(.ready)
                }
            }
        }
    }
    
    private func getCat() {
        network?.loadCats(items: queryItems){ [weak self] randomCat in
            DispatchQueue.main.async {
                if let newCat = randomCat {
                    self?.rootView.source.cats.append(newCat)
                    if let count = self?.rootView.source.cats.count {
                        self?.rootView.source.breedState[count-1] = .ready
                    }
                    self?.database?.saveCat(cat: newCat)
                }
            }
        }
    }
    
    public func getBreeds() {
        network?.loadBreeds { [weak self] breedList in
            DispatchQueue.main.async {
                if let safeBreeds = breedList {
                    self?.database?.saveBreeds(breeds: safeBreeds)
                    for i in 0..<safeBreeds.count {
                        if let cat = self?.database?.loadCatForBreed(breedId: safeBreeds[i].id) {
                            self?.rootView.source.cats.append(cat)
                            self?.rootView.source.breedState.append(.ready)
                        } else {
                            self?.rootView.source.breedState.append(.loading)
                            self?.queryItems.append(URLQueryItem(name: "breed_id", value: safeBreeds[i].id))
                            self?.getCat()
                            self?.queryItems.removeLast()
                        }
                    }
                }
            }
        }
    }
    
    private func sortCats() {
        let currentRaw = (self.rootView.source.catsSortedIndex + 1) % self.rootView.items.count
        let currentIndex = SortIdentifier(rawValue: currentRaw)
        self.rootView.source.catsSortedIndex = currentRaw
        self.rootView.source.cats.sort { (first, second) -> Bool in
            if let firstBreed = first.breeds.last, let secondBreed = second.breeds.last {
                switch currentIndex {
                case .Alphabet:
                    return firstBreed.name < secondBreed.name
                case .Adaptability:
                    return firstBreed.adaptability > secondBreed.adaptability
                case .Rare:
                    return firstBreed.rare > secondBreed.rare
                case .Intelligence:
                    return firstBreed.intelligence > secondBreed.intelligence
                case .Grooming:
                    return firstBreed.grooming > secondBreed.grooming
                case .Hairless:
                    return firstBreed.hairless > secondBreed.hairless
                case .Vocalisation:
                    return firstBreed.vocalisation > secondBreed.vocalisation
                case .Hypoallergenic:
                    return firstBreed.hypoallergenic > secondBreed.hypoallergenic
                case .none:
                    print("Some error")
                }
            }
            return true
        }
    }
    
    private func configureCommunication() {
        catsToken = rootView.publisher.sink { [weak self] message in
            switch message {
                case .load:
                    self?.getBreeds()
                case .sort:
                    self?.sortCats()
                case .delete:
                    self?.rootView.source.breedState = []
                    self?.rootView.source.cats = []
                    self?.database?.removeNotLikedCats()
                    self?.getBreeds()
                case .add:
                    print("Add in list (error in messages)")
                case .none:
                    print("Nothing there")
            }
        }
    }
    
}
