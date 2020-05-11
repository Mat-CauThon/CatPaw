//
//  BaseCat+CoreDataClass.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 04.05.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//
//

import CoreData


public final class BaseCat: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BaseCat> {
        return NSFetchRequest<BaseCat>(entityName: "BaseCat")
    }

    @NSManaged public var image: Data?
    @NSManaged public var id: String
    @NSManaged public var breedId: String?
    @NSManaged public var liked: Bool
    @NSManaged public var toBreed: NSSet?
    
}
