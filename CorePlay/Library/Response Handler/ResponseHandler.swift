import Foundation

let KEY_RESULT_TYPE = "Status"
let KEY_EXCEPTION = "Exception"
let KEY_MESSAGE = "Message"
let KEY_VALIDATION_ERROR = "ValidationErrors"
let KEY_DATA = "Data"

let ERROR_SERVER_NO_DATA = "Server didn't give response"
let ERROR_SERVER_WRONG_DATA = "Server didn't give proper response"
let ERROR_SERVER_WRONG_DATA_AR = "لم الملقم لا تعطي الرد المناسب"

class ResponseHandler {
    
    class func handleResponseStructure(networkResponseMessage: NetworkResponseMessage) ->(ParsedResponseMessage) {
        //var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
        
        let parsedResponse = ParsedResponseMessage()
        
        if let data = networkResponseMessage.data as? NSData {
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
            
               // let jsonObject: AnyObject = try JSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                
                let jsonDict = jsonObject
                
                if let resultType = jsonDict[KEY_RESULT_TYPE] as? Int {
                    
                    if let msg = jsonDict[KEY_MESSAGE] as? String{
                        parsedResponse.message = msg
                    }
                    
                    switch resultType {
                        
                    case ServiceResponseType.Success.rawValue:
                        
                        parsedResponse.serviceResponseType = .Success
                        parsedResponse.data = jsonDict as AnyObject?
                        
                    case ServiceResponseType.Failure.rawValue:
                        parsedResponse.serviceResponseType = .Failure
                        
                    case ServiceResponseType.DeActivated.rawValue:
                        parsedResponse.serviceResponseType = .DeActivated
                        
                    case ServiceResponseType.Warning.rawValue:
                        parsedResponse.serviceResponseType = .Warning
                        
                    case ServiceResponseType.Exception.rawValue:
                        parsedResponse.serviceResponseType = .Exception
                        if let exp = jsonDict[KEY_EXCEPTION] as? [String: AnyObject] {
                            parsedResponse.exception = exp.description
                        }
                        
                    case ServiceResponseType.ValidationError.rawValue:
                        parsedResponse.serviceResponseType = .ValidationError
                        if let valErrors = jsonDict[KEY_VALIDATION_ERROR] as? [AnyObject] {
                            var errArray = [String]()
                            
                            for err in valErrors{
                                if let errObj = err as? [String:AnyObject]{
                                    if let friendlyMsg = errObj["errorMessage"] as? String{
                                        errArray.append(friendlyMsg)
                                    }
                                }
                            }
                            parsedResponse.validationErrors = errArray
                        }
                        
                    default:
                        parsedResponse.message = ERROR_SERVER_WRONG_DATA
                    }
                }
                else{
                    parsedResponse.message = ERROR_SERVER_WRONG_DATA
                }
            } catch _ {
                /* TODO: Finish migration: handle the expression passed to error arg: error */
                // Server didn't give proper response
                parsedResponse.message = ERROR_SERVER_WRONG_DATA
            }
        }
        else{
            // Server Didn't give us response
            parsedResponse.message = ERROR_SERVER_NO_DATA
        }
        
        return parsedResponse
    }
    class func handleComitteeContactResponse(networkResponseMessage: NetworkResponseMessage) ->(ParsedResponseMessage) {
        
        let parsedResponse = ResponseHandler.handleResponseStructure(networkResponseMessage: networkResponseMessage)
        
        if parsedResponse.serviceResponseType == .Success{
            if let jsonDict = parsedResponse.data as? [String: AnyObject]{
                //if  let jsonDate = jsonDict["Data"] as?[String:AnyObject]{
                var error2 : NSError? = nil
                
                let setup : ComitteeContact!
                do {
                    setup = try ComitteeContact(dictionary: jsonDict )
                } catch let error as NSError {
                    error2 = error
                    setup = nil
                }
                
                if let err = error2 {
                    print(err)
                    parsedResponse.serviceResponseType = .Failure
                    parsedResponse.message = ERROR_SERVER_WRONG_DATA
                    parsedResponse.data = nil
                }
                else{
                    parsedResponse.data = setup
                }
                //                }
                //                else{
                //                    parsedResponse.serviceResponseType = .Failure
                //                    parsedResponse.message = ERROR_SERVER_WRONG_DATA
                //                    parsedResponse.data = nil
                //                }
            }
        }
        
        return parsedResponse
    }
    
//    class func handleTreeResponse(networkResponseMessage networkResponseMessage: NetworkResponseMessage) ->(ParsedResponseMessage) {
//        
//        let parsedResponse = ResponseHandler.handleResponseStructure(networkResponseMessage: networkResponseMessage)
//        
//        if parsedResponse.serviceResponseType == .Success{
//            if let jsonDict = parsedResponse.data as? [String: AnyObject]{
//                
//                var error2 : NSError? = nil
//                
//                let nodeList : NodeList!
//                do {
//                    nodeList = try NodeList(dictionary: jsonDict)
//                } catch let error as NSError {
//                    error2 = error
//                    nodeList = nil
//                }
//                
//                if let err = error2 {
//                    print(err)
//                    parsedResponse.serviceResponseType = .Failure
//                    parsedResponse.message = ERROR_SERVER_WRONG_DATA
//                    parsedResponse.data = nil
//                }
//                else{
//                    parsedResponse.data = nodeList
//                }
//            }
//            else{
//                parsedResponse.serviceResponseType = .Failure
//                parsedResponse.message = ERROR_SERVER_WRONG_DATA
//                parsedResponse.data = nil
//            }
//        }
//        
//        return parsedResponse
//    }
//    
//    class func handleWorthyListResponse(networkResponseMessage networkResponseMessage: NetworkResponseMessage) ->(ParsedResponseMessage) {
//        
//        let parsedResponse = ResponseHandler.handleResponseStructure(networkResponseMessage: networkResponseMessage)
//        
//        if parsedResponse.serviceResponseType == .Success{
//            if let jsonDict = parsedResponse.data as? [String: AnyObject]{
//                
//                var error2 : NSError? = nil
//                
//                let nodeList : WorthyList!
//                do {
//                    nodeList = try WorthyList(dictionary: jsonDict)
//                } catch let error as NSError {
//                    error2 = error
//                    nodeList = nil
//                }
//                
//                if let err = error2 {
//                    print(err)
//                    parsedResponse.serviceResponseType = .Failure
//                    parsedResponse.message = ERROR_SERVER_WRONG_DATA
//                    parsedResponse.data = nil
//                }
//                else{
//                    parsedResponse.data = nodeList
//                }
//            }
//            else{
//                parsedResponse.serviceResponseType = .Failure
//                parsedResponse.message = ERROR_SERVER_WRONG_DATA
//                parsedResponse.data = nil
//            }
//        }
//        
//        return parsedResponse
//    }

  

}
