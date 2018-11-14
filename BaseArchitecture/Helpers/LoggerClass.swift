//
//  LoggerClass.swift
//  BaseArchitecture
//
//  Created by Ashutosh Mishra on 30/08/18.
//  Copyright © 2018 i2e1. All rights reserved.
//

import UIKit

class LoggerClass: NSObject {
    
    static let isDebug : Bool = true
    
    static func logDebug(method : String, message : String){
        if isDebug{
            print("Debug:::\(method)~~~\(message)")
        }
    }
    
    static func logError(method : String, message : String){
        print("Error:::\(method)~~~\(message)")
    }

}
