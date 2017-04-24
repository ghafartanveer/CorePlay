//
//  BaseNetwork.swift
//  CodeStructure
//
//  Created by Ghafar Tanveer on 01/04/2017.
//  Copyright © 2017 Ghafar Tanveer. All rights reserved.
//

import Foundation


class BaseNetwork{
    private func configurePostRequest( request:inout NSMutableURLRequest,requestMessage:NetworkRequestMessage){
        
        request.httpMethod = "POST"
        
        if(requestMessage.contentType == ContentType.JSON){
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestMessage.params, options: .prettyPrinted)
                request.httpBody = jsonData
            } catch _ {
                /* TODO: Finish migration: handle the expression passed to error arg: error */
            }
        }else if requestMessage.contentType == ContentType.HTML {
            
            var queryString = ""
            
            for (key,value) in requestMessage.params {
                let valueString = "\(value)".htmlEncodedString()
                queryString = "\(queryString)\(key)=\(valueString)&"
            }
            
            if queryString.characters.count > 0{
                queryString = queryString.substring(from: queryString.endIndex)// substringToIndex(queryString.endIndex.predecessor())
            }
            
            print("----- POST Request -----")
            print("URL : \(request.url)")
            print("Query String : \(queryString)")
            print("----- POST Request -----")
            request.httpBody = queryString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        }

    }
    
    private func configureGetRequest(request:inout NSMutableURLRequest , requestMessage : NetworkRequestMessage) {
        
        request.httpMethod = "GET"
        
        var queryString = ""
        
        for (key,value) in requestMessage.params {
            queryString = "\(queryString)\(key)=\(value)&"
        }
        
        if queryString.characters.count > 2{
            queryString = queryString.substring(from: queryString.endIndex)
            //queryString = queryString.substringToIndex(queryString.endIndex.predecessor())
        }
        
        print(queryString)
        
        if let reallyURL = NSURL(string: requestMessage.url + "?" + queryString){
            request.url = reallyURL as URL
        }
        else{
            
        }
        
        print("----- GET Request -----")
        print("URL : \(request.url)")
        print("Query String : \(queryString)")
        print("----- GET Request -----")
    }
    private func configureRequest (request:inout NSMutableURLRequest , requestMessage : NetworkRequestMessage) {
        
        switch requestMessage.requestType {
            
        case RequestType.GET:
            
            self.configureGetRequest(request: &request, requestMessage: requestMessage)
            
        case RequestType.POST:
            
            self.configurePostRequest(request: &request, requestMessage: requestMessage)
            
        case RequestType.PUT:
            
            request.httpMethod = "PUT"
            
        case RequestType.DELETE:
            
            request.httpMethod = "DELETE"
            
        case RequestType.HEAD:
            
            request.httpMethod = "HEAD"
            
        case RequestType.OPTIONS:
            
            request.httpMethod = "OPTIONS"
            
        }
    }
    private func addCustomHeaders(request:inout NSMutableURLRequest){
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }
    
    func performNetworkTask(requestMessage : NetworkRequestMessage) -> (NetworkResponseMessage) {
        
        let responseMessage = NetworkResponseMessage()
        
        if let reallyURL = NSURL(string: requestMessage.url){
            
            var request = NSMutableURLRequest(url: reallyURL as URL)
            self.addCustomHeaders(request: &request)
            self.configureRequest(request: &request, requestMessage: requestMessage)
            
            let response:AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil;
            var error: NSError? = nil
            
            do {
                let responseData = try NSURLConnection.sendSynchronousRequest(request as URLRequest,returning: response)
                
                if let err = error{
                    
                    if err.code == NSURLErrorTimedOut {
                        responseMessage.statusCode = StatusCode.Timeout
                    } else {
                        responseMessage.statusCode = StatusCode.Failure
                    }
                    responseMessage.message = err.description
                } else {
                    
                    //let responseInStringFormat : NSString = NSString(data:responseData, encoding:NSUTF8StringEncoding)!
                    let responseInStringFormat : String = String(data: responseData, encoding: String.Encoding.utf8)!
                    print("----- Response -----")
                    print("\(responseInStringFormat)")
                    print("----- Response -----")
                    
                    responseMessage.statusCode = StatusCode.Success
                    responseMessage.message = "Success"
                    responseMessage.data = responseData as AnyObject?
                }
            } catch let error1 as NSError {
                error = error1
                responseMessage.statusCode = StatusCode.Failure
                responseMessage.message = "Generic Error - Will do a generic error handler class"
            }
            
            return responseMessage
        }
        else{
            return responseMessage
        }
    }

}
