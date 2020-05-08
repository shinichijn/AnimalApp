//
//  dbmanger.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 3/7/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit
import RealmSwift


class DBManager: NSObject {
    
    static let shared = DBManager()
    let realm = try! Realm()
    
    
    private override init() {
        super.init()
        
    }
    
    
      func getAnimals() -> Results<animalM>?{
        
        let animalData = { self.realm.objects(animalM.self).sorted(byKeyPath: "created",ascending: false) }()
        return animalData
    }
    
    
    
    func getAnimalsByType(type:String?) -> Results<animalM>?{
        
        let filter = type ?? ""
        let aPredicate = NSPredicate(format: "typeName == %@", filter)
        let animalData = { self.realm.objects(animalM.self).filter(aPredicate).sorted(byKeyPath: "created",ascending: false) }()
        return animalData
    }
    
    
    
    func addAnimal(animal: animalM)
    {
        try! self.realm.write() {
            
            self.realm.add(animal)
        }
        
    }
    
    func changeCommetByObject(animal: animalM, comment: String?){
        
        try! self.realm.write {
            animal.comment = comment ?? ""
        }
    }
    





}
