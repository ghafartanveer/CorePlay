//
//  ComitteeContact.swift
//  CourPlay
//
//  Created by Ghafar Tanveer on 24/04/2017.
//  Copyright © 2017 Ghafar Tanveer. All rights reserved.
//

import Foundation
import JSONModel

class ComitteeContact: JSONModel {
   
    var contacts:NSArray
     = []
    override class func keyMapper() -> JSONKeyMapper {
        
        let dict = ["contacts"   : "Data"]
        return JSONKeyMapper(modelToJSONDictionary: dict)
    }
    override class func propertyIsOptional(_ propertyName:String!) -> Bool{
        if(propertyName == "dasda"){
            return true
        }
        return false
    }
}
