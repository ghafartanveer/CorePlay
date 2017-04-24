//
//  BaseViewController.swift
//  AlKadi
//
//  Created by Khurram Bilal Nawaz on 22/07/2016.
//  Copyright © 2016 Khurram Bilal Nawaz. All rights reserved.
//

import Foundation
import UIKit


import MBProgressHUD


extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    var snapshot: UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}


extension UIViewController{
    
    var mainContainerController : MainViewController? {
        
        get{
            var foundController: MainViewController? = nil
            var currentViewController : UIViewController? = self
            
            if(self.isKind(of: MainViewController.self)){
                foundController = (self as! MainViewController)
            }else{
                while true{
                    if let parent = currentViewController?.parent {
                        if parent.isKind(of: MainViewController.self){
                            foundController = (parent as! MainViewController)
                            break
                        }else if parent.isKind(of: BaseNavigationController.self){
                            let navController = parent as! BaseNavigationController
                            if let parentController = navController.view.superview?.parentViewController{
                                if parentController.isKind(of: MainViewController.self){
                                    foundController = (parentController as! MainViewController)
                                    break
                                }
                            }
                        }
                        
                    }
                    else {
                        break
                    }
                    currentViewController = currentViewController?.parent
                }
            }
            
            return foundController
        }
    }
}


public class BaseViewController : UIViewController {
    
    var hud = MBProgressHUD()
    
    var disableMenuGesture: Bool = false
    var objAlertVC:BaseViewController?
    var datePickerView: UIDatePicker = UIDatePicker()

    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    func languageUpdated(){
        
    }
    
    
    func startActivity (containerView: UIView? = nil) {
        
       
        if let v = containerView{
            self.hud = MBProgressHUD.showAdded(to: v, animated:true)
        }else{
            self.hud = MBProgressHUD.showAdded(to: self.view, animated:true)
        }
        self.hud.color = UIColor(red:255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha:0.0)
        //self.setBorderColor(self.hud, red: 198.0/255.0, green: 176.0/255.0, blue: 157.0/255.0, alpha: 0.75)
        
        self.hud.mode = MBProgressHUDMode.customView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 87, height: 87))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        imageView.animationDuration = 1.6
        
        var images : [UIImage] = [UIImage]()
        for i in 0...23 {
            if let img = UIImage(named: "LoaderAnimation\(i).png") {
                images.append(img)
            }
        }

        imageView.animationImages = images
        imageView.startAnimating()

        self.hud.customView = imageView
    }
    
    func stopActivity (containerView: UIView? = nil) {
        if let v = containerView{
            MBProgressHUD.hide(for: v, animated: true)
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func startActivityWithMessage (msg:String, detailMsg: String = "") {
        self.hud = MBProgressHUD.showAdded(to: self.view, animated:true)
        self.hud.labelText = msg
        self.hud.detailsLabelText = detailMsg
    }
    
    func startActivityInView(view: UIView) {
        self.hud = MBProgressHUD.showAdded(to: view, animated:true)
        
        //self.hud.activityIndicatorColor = UIColor.blackColor()
        //self.hud.color = UIColor.clearColor()
        self.hud.layoutSubviews()
    }
    
    func updateActivityMessage (msg:String, detailMsg: String = "") {
        self.hud.labelText = msg
        self.hud.detailsLabelText = detailMsg
    }
    
    func handleDefaultResponse(response: ServiceResponseMessage) {
        
        if response.serviceResponseType != .Success {
            //let message = response.message
            //UIAlertView(title: "Failure", message: message, delegate: nil, cancelButtonTitle: "OK").show()
        }
        
    }
    
    //socialNetworksPopupVc
}



