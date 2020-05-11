//
//  BaseBreed+CoreDataClass.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 04.05.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//
//

import CoreData


public final class BaseBreed: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BaseBreed> {
        return NSFetchRequest<BaseBreed>(entityName: "BaseBreed")
    }
    func retBreed() -> Breed {
        return Breed(id: id, adaptability: Int(adaptability), intelligence: Int(intelligence), vocalisation: Int(vocalisation), grooming: Int(grooming), hairless: Int(hairless), desc: desc, hypoallergenic: Int(hypoallergenic), name: name, temperament: temperament, rare: Int(rare))
    }

    @NSManaged public var id: String
    @NSManaged public var adaptability: Int16
    @NSManaged public var intelligence: Int16
    @NSManaged public var vocalisation: Int16
    @NSManaged public var grooming: Int16
    @NSManaged public var hairless: Int16
    @NSManaged public var desc: String
    @NSManaged public var hypoallergenic: Int16
    @NSManaged public var name: String
    @NSManaged public var temperament: String
    @NSManaged public var rare: Int16
    @NSManaged public var ofCat: NSSet
    
}
