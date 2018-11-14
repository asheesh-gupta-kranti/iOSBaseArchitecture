//
//  LoginVM.swift
//  BaseArchitecture
//
//  Created by Ashutosh Mishra on 30/08/18.
//  Copyright © 2018 i2e1. All rights reserved.
//

import UIKit

class LoginVM: NSObject {
    
    private var requestUseCase :LoginRequest?
    
    func performSignInForCredentials(mobile : String, appId : String, mac : String, completionHandler :@escaping (String?)->Void,useCase : LoginRequest = LoginRequest()) {
        
        let requestDTO = LoginRequestDTO(mobile: mobile, appId: appId, mac: mac)
        requestUseCase = useCase
        requestUseCase?.initialize(requestDTO: requestDTO, completionHandler: { (responseDTO, error) in
            if(error != nil)
            {
                completionHandler("Error message")
            }
            else
            {
                LoggerClass.logDebug(method: "performSignInForCredentials", message: "\(responseDTO?.msg)")
                LoggerClass.logDebug(method: "performSignInForCredentials", message: "\(responseDTO?.data.message)")
                completionHandler("Success login")
            }
        })
    }
}
