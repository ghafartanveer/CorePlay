//
//  BReachability.swift
//  AlKadi
//
//  Created by Khurram Bilal Nawaz on 22/07/2016.
//  Copyright © 2016 Khurram Bilal Nawaz. All rights reserved.
//

import Foundation
import SystemConfiguration

public enum BReachabilityType {
    case WWAN,
    WiFi,
    NotConnected
}

public class BReachability {
    
//    public class func isConnectedToNetwork() -> Bool {
//        
//        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
//        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        
//        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
//            SCNetworkReachabilityCreateWithAddress(nil, $0).takeRetainedValue()
//        }
//        
//        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags.ConnectionRequired
//        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
//            return false
//        }
//        
//        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        
//        return (isReachable && !needsConnection) ? true : false
//    }
    
//    class func isConnectedToNetwork() -> Bool {
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer())
//            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
//        }
//        var flags = SCNetworkReachabilityFlags()
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability as! SCNetworkReachability, &flags) {
//            return false
//        }
//        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        return (isReachable && !needsConnection)
//    }

    
//    public class func isConnectedToNetworkOfType() -> BReachabilityType {
//        
//        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
//        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        
//        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
//            SCNetworkReachabilityCreateWithAddress(nil, ($0)).takeRetainedValue()
//        }
//        
//        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags.ConnectionRequired
//        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
//            return .NotConnected
//        }
//        
//        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//        let isWWAN = (flags.rawValue & SCNetworkReachabilityFlags.IsWWAN.rawValue) != 0
//        //let isWifI = (flags & UInt32(kSCNetworkReachabilityFlagsReachable)) != 0
//        
//        if(isReachable && isWWAN){
//            return .WWAN
//        }
//        if(isReachable && !isWWAN){
//            return .WiFi
//        }
//        
//        return .NotConnected
//    }
}
