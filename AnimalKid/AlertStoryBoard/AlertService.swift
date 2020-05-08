//
//  AlertService.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 2/28/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit

class AlertService {
    
    func alert(labelTitle:String, imageData:UIImage , completion: @escaping (animalM)-> Void) -> alertControllerViewController {
        let storyboard = UIStoryboard(name: "alertStoryBoard", bundle:.main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier:"AlertVC") as! alertControllerViewController
        
        alertVC.labelTitle = labelTitle
        let data: NSData = (UIImageJPEGRepresentation(imageData, 0.1) as NSData?)!
        alertVC.imageData = data as! NSData
        alertVC.buttonAtion = completion
        return alertVC
    }
    
    
}
