//
//  MainViewController.swift
//  CodeStructure
//
//  Created by Ghafar Tanveer on 01/04/2017.
//  Copyright © 2017 Ghafar Tanveer. All rights reserved.
//

import UIKit
import MBProgressHUD

class MainViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadCommitteeContacts()
    }
    @IBAction func movenext(_ sender: Any) {
        
        self.performSegue(withIdentifier: "nextVC", sender: self)
    }
    func loadCommitteeContacts()  {
        //gcd.async(queueType: .Default) {
        //}
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let requestMessage = ServiceRequestMessage()
        
        let service = ComitteeContactService()
        let responseMessage = service.getComitteeContact(requestMessage: requestMessage)
        MBProgressHUD.hide(for: self.view, animated: true)
        
        switch responseMessage.serviceResponseType {
        case .Success:
            
            if let contactsVM = responseMessage.data as? ComitteeContactViewModel{
                print(contactsVM)
            }else {
                print("Error loadCommitteeContacts")
            }
            
            
        case .Failure:
            print("Marked Fail: loadCommitteeContacts")
            
            
        default:
            print(responseMessage.message)
            
        }
        //}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
