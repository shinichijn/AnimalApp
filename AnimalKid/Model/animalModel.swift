//
//  animalModel.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 2/29/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import Foundation
import RealmSwift

class animalM: Object{
    @objc dynamic var imageName:String = ""
    @objc dynamic var typeName:String = ""
    @objc dynamic var comment:String = ""
    @objc dynamic var image:NSData?
    @objc dynamic var created = Date()
    

    
}



/*
 
 Request {
 
 imageName:String
 var typeName:String
 var comment:String
 var image:Base64
 var created = String
 }
 
 Response {
 
 type:String,
 messages:String,
 success:Bool
 
 }
 
 
 
 */
