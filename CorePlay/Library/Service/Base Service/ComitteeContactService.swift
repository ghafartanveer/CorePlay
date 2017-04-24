//
//  ComitteeContactService.swift
//  AlKadi
//
//  Created by Ghafar Tanveer on 13/02/2017.
//  Copyright © 2017 Khurram Bilal Nawaz. All rights reserved.
//

import Foundation
class ComitteeContactService: BaseService {
    func getComitteeContact(requestMessage: ServiceRequestMessage) -> ServiceResponseMessage
    {
        
        let homeURL = URL_COMITTEE_CONTACT
        
        let params:[String: AnyObject] = [String: AnyObject]()
        
        let networkRequestMessage = NetworkRequestMessage(requestType: RequestType.GET, contentType: ContentType.HTML, url: homeURL, params: params)
        
        let networkResponseMessage = BaseNetwork().performNetworkTask(requestMessage: networkRequestMessage)
        
        switch networkResponseMessage.statusCode {
            
        case .Success:
            
            let parsedResponse = ResponseHandler.handleComitteeContactResponse(networkResponseMessage: networkResponseMessage)
            
            switch parsedResponse.serviceResponseType{
                
            case .Success:
                
                if let contactsDM = parsedResponse.data as? ComitteeContact {
                    
                    let serviceResponse = self.getSuccessResponseMessage()
                    let contactsVM = ComitteeContactViewModel(contacts: contactsDM)
                    serviceResponse.data = contactsVM
                    return serviceResponse
                }
                else{
                    return self.getErrorResponseMessage(message: "Setup Detail : Invalid Response from server" as AnyObject?)
                }
                
            default:
                return self.getDefaultServiceResponse(response: parsedResponse)
            }
        case .Failure:
            return self.getErrorResponseMessage(message: "Setup Detail Request Failed" as AnyObject?)
        case .Timeout:
            return self.getTimeoutErrorResponseMessage(message: "Setup Detail Request Timeout" as AnyObject?)
        }
    }

}
