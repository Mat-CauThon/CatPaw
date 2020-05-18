//
//  Database.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 04.05.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import CoreData
import SwiftUI

final class Database {
    
    private let context = PersistentService.context
    private let catsFetchedResultsController: NSFetchedResultsController<BaseCat>
    private let breedsFetchedResultsController: NSFetchedResultsController<BaseBreed>
    private let catFetchRequest: NSFetchRequest<BaseCat> = BaseCat.fetchRequest()
    private let breedFetchRequest: NSFetchRequest<BaseBreed> = BaseBreed.fetchRequest()
    
    init() {
        catFetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        breedFetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        catsFetchedResultsController = NSFetchedResultsController(
            fetchRequest: catFetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        breedsFetchedResultsController = NSFetchedResultsController(
        fetchRequest: breedFetchRequest,
        managedObjectContext: context,
        sectionNameKeyPath: nil,
        cacheName: nil)
    }
    
    public func loadBreeds() -> [Breed] {
        do {
            try breedsFetchedResultsController.performFetch()
        } catch let error {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        var breeds: [Breed] = []
        if let savedBreeds = breedsFetchedResultsController.fetchedObjects {
            for breed in savedBreeds {
                breeds.append(breed.retBreed())
            }
        }
        return breeds
    }
    
    public func loadBreedForId(breedId: String) -> Breed? {
        let predicate = NSPredicate(format: "id = %@", breedId)
        breedFetchRequest.predicate = predicate
        do {
            try breedsFetchedResultsController.performFetch()
        } catch let error {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        if let fetched = breedsFetchedResultsController.fetchedObjects {
            for breed in fetched {
                return breed.retBreed()
            }
        }
        return nil
    }
    
    public func saveBreed(breed: Breed) {
        let toSave = BaseBreed(context: PersistentService.context)
        toSave.adaptability = Int16(breed.adaptability)
        toSave.desc = breed.desc
        toSave.grooming = Int16(breed.grooming)
        toSave.hairless = Int16(breed.hairless)
        toSave.hypoallergenic = Int16(breed.hypoallergenic)
        toSave.id = breed.id
        toSave.intelligence = Int16(breed.intelligence)
        toSave.name = breed.name
        toSave.rare = Int16(breed.rare)
        toSave.temperament = breed.temperament
        toSave.vocalisation = Int16(breed.vocalisation)
        do {
            try context.save()
        } catch let error {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    public func saveBreeds(breeds: [Breed]) {
        var count = 0
        do {
            try count = context.count(for: breedFetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        if count != breeds.count {
            var forSave = breeds
            for item in loadBreeds() {
                forSave = forSave.filter { (breed) -> Bool in
                    breed.id != item.id
                }
            }
            for breed in forSave {
                saveBreed(breed: breed)
            }
        }
    }
    
    public func loadCatForBreed(breedId: String) -> CatClass? {
        let predicate = NSPredicate(format: "breedId = %@", breedId)
        catFetchRequest.predicate = predicate
        do {
            try catsFetchedResultsController.performFetch()
        } catch let error {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        var savedCat: CatClass? = nil
        if let fetched = catsFetchedResultsController.fetchedObjects {
            for cat in fetched {
                var breeds: [Breed] = []
                if let safeBreed = loadBreedForId(breedId: breedId) {
                    breeds.append(safeBreed)
                }
                if let imageData = cat.image, let image = UIImage(data: imageData) {
                    savedCat = CatClass(id: cat.id, breeds: breeds, image: image)
                }
            }
        }
        return savedCat
    }
    
    public func loadCats(savedCats: [BaseCat]) -> [CatClass] {
        var cats: [CatClass] = []
        for cat in savedCats {
            var breeds: [Breed] = []
            if let safeBreed = loadBreedForId(breedId: cat.breedId ?? "nil") {
                breeds.append(safeBreed)
            }
            if let imageData = cat.image, let image = UIImage(data: imageData) {
                cats.append(CatClass(id: cat.id, breeds: breeds, image: image))
            }
        }
        return cats
    }
    
    public func loadLikedCats() -> [CatClass] {
        do {
            try catsFetchedResultsController.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        let fetchedCats = catsFetchedResultsController.fetchedObjects?.filter{ cat -> Bool in
            cat.liked
        }
        if let fetched = fetchedCats {
            return loadCats(savedCats: fetched)
        }
        return []
    }
    
    public func saveCat(cat: CatClass) {
        let toSave = BaseCat(context: context)
        toSave.id = cat.id
        toSave.liked = cat.liked
        toSave.image = cat.image.jpegData(compressionQuality: 0.9)
        toSave.breedId = nil
        if let breed = cat.breeds.first {
            toSave.breedId = breed.id
        }
        do {
            try context.save()
        } catch let error {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    public func removeCat(id: String) {
        catFetchRequest.predicate = NSPredicate.init(format: "id = %@", id)
        if let result = try? context.fetch(catFetchRequest) {
            for object in result {
                context.delete(object)
                do {
                    try context.save()
                } catch let error {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
    public func removeNotLikedCats() {
        catFetchRequest.predicate = NSPredicate.init(format: "liked = %@", "false")
        if let result = try? context.fetch(catFetchRequest) {
            for object in result {
                context.delete(object)
                do {
                    try context.save()
                } catch let error {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
}
