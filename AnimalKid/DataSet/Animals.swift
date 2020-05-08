//
//  Animals.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 2/27/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import Foundation
import UIKit

struct Animals
{
    let imageName: String
    let typeName: String
    let comment:String
    let image:UIImage?
    
    static func fetchAnimal() -> [Animals] {
        let v1 = Animals(imageName: "cat1.jpeg", typeName: "CAT", comment: "CAT", image: nil)
         let v2 = Animals(imageName: "cat2.jpg", typeName: "CAT", comment: "CAT", image: nil)
         let v3 = Animals(imageName: "dog1.jpg", typeName: "CAT", comment: "CAT", image: nil)
         let v4 = Animals(imageName: "dog2.jpg", typeName: "CAT", comment: "CAT", image: nil)
         let v5 = Animals(imageName: "dog3.jpg", typeName: "CAT", comment: "CAT", image: nil)
         let v6 = Animals(imageName: "dog4.jpg", typeName: "CAT", comment: "CAT", image: nil)
        
        return [v1, v2, v3, v4, v5, v6]
    }
    
    
    
    
    
}
