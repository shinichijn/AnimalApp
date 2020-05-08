//
//  JsonObject.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 3/7/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import Foundation
import SwiftyJSON


struct responseObject {
    
    let typeName:String
    
}


struct requestObject {
    let imageName:String
    let comment:String
    let image:String
    let created: String
}


//
//let data = requestObject( imageName: "name2", comment: "name3", image: "name4", created: "name5")
//let request = JsonObject.shared.regcongitionRequst(data: data)


class JsonObject: NSObject {

      static let shared = JsonObject()
    
    private override init() {
        super.init()
        
    }
    
    
    func regcongitionRequst(data: requestObject) -> JSON?
    {
        var json: JSON?
        
        
        if (data.imageName != nil) {
            
            if (json == nil)
            {
                json = JSON(["typeName":data.imageName])
            }
            else
            {
                let new = JSON(["typeName":data.imageName])
                try! json?.merge(with: new)
            }
            
            
           
            
        }
        
        if (data.comment != nil) {
            
            if (json == nil)
            {
                json = JSON(["comment":data.comment])
            }
            else
            {
                let new = JSON(["comment":data.comment])
                try! json?.merge(with: new)
            }
            
            
            
        }
        
        if (data.image != nil) {
            
            if (json == nil)
            {
                json = JSON(["image":data.image])
            }
            else
            {
                let new = JSON(["image":data.image])
                try! json?.merge(with: new)
            }
            
            
        }
        
        if (data.created != nil) {
            
            
            if (json == nil)
            {
                json = JSON(["created":data.created])
            }
            else
            {
                let new = JSON(["created":data.created])
                try! json?.merge(with: new)
            }
            
            
        }
        
        
        if (json == nil)
        {
            return nil
            
        }
        else
        {
            return json
        }
        
        
       
    }
    
    func regcongitionResponse(data :Data?) -> responseObject? {
        
       // let dataFromString = data?.data(using: .utf8, allowLossyConversion: false)
    
        let res = try! JSON(data: data!)
         if (res == nil)
         {
            return nil
        }
        let name = res["animal"].stringValue
        return responseObject(typeName: name)
    }


}
