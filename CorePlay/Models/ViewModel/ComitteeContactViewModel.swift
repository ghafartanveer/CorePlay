//
//  ComitteeContactViewModel.swift
//  AlKadi
//
//  Created by Ghafar Tanveer on 13/02/2017.
//  Copyright © 2017 Khurram Bilal Nawaz. All rights reserved.
//

import Foundation
class ComitteeContactViewModel {
    var id:String
    var contactType:String
    
    //Family
    var email:String
    var isShowEmail:Bool
    var phone:String
    var isShowPhone:Bool
    var message:String
    var isShowMessage:Bool
    //var status:String
    
    //guest
    var emailGuest:String
    var isShowEmailGuest:Bool
    var phoneGuest:String
    var isShowPhoneGuest:Bool
    var messageGuest:String
    var isShowMessageGuest:Bool
    //var statusGuest:String
    
    
    var workinghours:String
    var workingHoursDescription:String
    var tawasulEmail:String
    
    init() {
        self.id = ""
        self.contactType = ""
        self.email = ""
        self.isShowEmail = false
        self.phone = ""
        self.isShowPhone = false
        self.message = ""
        self.isShowMessage = false
        //self.status = ""
        
        self.emailGuest = ""
        self.isShowEmailGuest = false
        self.phoneGuest = ""
        self.isShowPhoneGuest = false
        self.messageGuest = ""
        self.isShowMessageGuest = false
        //self.statusGuest = ""
        
        self.workinghours = ""
        self.workingHoursDescription = ""
        self.tawasulEmail = ""
        
    }
    
    init(contacts: ComitteeContact) {
        self.id = ""
        self.contactType = ""
        self.email = ""
        self.isShowEmail = false
        self.phone = ""
        self.isShowPhone = false
        self.message = ""
        self.isShowMessage = false
        //self.status = ""
        
        self.emailGuest = ""
        self.isShowEmailGuest = false
        self.phoneGuest = ""
        self.isShowPhoneGuest = false
        self.messageGuest = ""
        self.isShowMessageGuest = false
        //self.statusGuest = ""
        
        self.workinghours = ""
        self.workingHoursDescription = ""
        self.tawasulEmail = ""
        
        for item in contacts.contacts {
            let itemDic = item as! NSDictionary
            if (itemDic["contact_type"] as! String) == "Private" {
                self.email = itemDic["email"] as! String
                self.isShowEmail = (itemDic["show_email"] as! String).lowercased() == "yes" ? true : false
                self.phone = itemDic["phone"] as! String
                self.isShowPhone = (itemDic["show_phone"] as! String).lowercased() == "yes" ? true : false
                self.message = itemDic["instant_messaging"] as! String
                self.isShowMessage = (itemDic["show_instant_messaging"] as! String).lowercased() == "yes" ? true : false
                
            }else if (itemDic["contact_type"] as! String) == "Guest" {
                self.emailGuest = itemDic["email"] as! String
                self.isShowEmailGuest = (itemDic["show_email"] as! String).lowercased() == "yes" ? true : false
                self.phoneGuest = itemDic["phone"] as! String
                self.isShowPhoneGuest = (itemDic["show_phone"] as! String).lowercased() == "yes" ? true : false
                self.messageGuest = itemDic["instant_messaging"] as! String
                self.isShowMessageGuest = (itemDic["show_instant_messaging"] as! String).lowercased() == "yes" ? true : false
                
            }else if (itemDic["contact_type"] as! String) == "Hours" {
                self.workinghours = itemDic["working_hours"] as! String
                self.workingHoursDescription = itemDic["working_hours_description"] as! String
                
            }else if (itemDic["contact_type"] as! String) == "Twasul" {
                self.tawasulEmail = itemDic["twasul_email"] as! String
            }
        }
    }
    
    
}
