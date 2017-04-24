import Foundation

public class BaseService {
    
    public init() {
        
    }
    
    func getValidationErrorResponseMessage (validationErrors: [String])->(ServiceResponseMessage) {
        
        let responseMessage = ServiceResponseMessage()
        responseMessage.serviceResponseType = ServiceResponseType.ValidationError
        responseMessage.validationErrors = validationErrors
        
        return responseMessage
    }
    
    func getSuccessResponseMessage (message:String = STRING_SUCCESS)->(ServiceResponseMessage) {
        
        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = ServiceResponseType.Success
        svcResponse.message = message
        
        return svcResponse
    }
    
    func getErrorResponseMessage (message: AnyObject?)->(ServiceResponseMessage) {
        
        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = ServiceResponseType.Failure
        
        if let messageText = message as? String {
            svcResponse.message = messageText
        } else {
            svcResponse.message = STRING_UNEXPECTED_ERROR
        }
        
        return svcResponse
    }
    
    func getDefaultServiceResponse(response: ParsedResponseMessage)-> (ServiceResponseMessage){
        
        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = response.serviceResponseType
        svcResponse.message = response.message
        
        return svcResponse
    }
    
    func getTimeoutErrorResponseMessage (message: AnyObject?)->(ServiceResponseMessage) {
        
        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = ServiceResponseType.Timeout
        
        if let messageText = message as? String {
            svcResponse.message = messageText
        } else {
            svcResponse.message = STRING_UNEXPECTED_ERROR
        }
        
        return svcResponse;
    }
    
    func getServerErrorResponseMessage (message: AnyObject?)->(ServiceResponseMessage) {
        
        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = ServiceResponseType.ServerError
        
        if let messageText = message as? String {
            svcResponse.message = messageText
        } else {
            svcResponse.message = STRING_UNEXPECTED_ERROR
        }
        
        return svcResponse
    }
    
    func getInternetErrorResponseMessage (message: AnyObject?)->(ServiceResponseMessage) {
        
        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = ServiceResponseType.NoInternetConnection
        
        if let messageText = message as? String {
            svcResponse.message = messageText
        } else {
            svcResponse.message = STRING_UNEXPECTED_ERROR
        }
        
        return svcResponse
    }
}