//
//  LoginRequest.swift
//  BaseArchitecture
//
//  Created by Ashutosh Mishra on 30/08/18.
//  Copyright © 2018 i2e1. All rights reserved.
//

import UIKit

struct LoginRequestDTO : BaseRequestDTO {
    var mobile : String
    var appId : String
    var mac : String
    
    func createGetRequestUrl(url:String)-> URL?{
        //TODO : create
        
        return URL(string: url + Constants.loginEndPoint + "?utm_campaign=direct&utm_source=direct&utm_medium=direct")
    }
    func createParamsDictionary() -> [String : String]? {
        var parameters : [String : String] = [:]
        parameters["mobile"] = mobile
        parameters["appId"] = appId
        parameters["mac"] = mac
        
        parameters["countryCode"] = "91"
        parameters["version"] = "1.2.0"
        parameters["brand"] = "Apple"
        parameters["model"] = "iPhone7"
        parameters["ios_version"] = "11.4"
        
        return parameters
    }
}
struct LoginResponseDTO : BaseResponseDTO ,Decodable{
    var msg : String?
    var status : Int?
    var data : LoginModel
}

class LoginRequest: BaseRequestUseCase<LoginRequestDTO,LoginResponseDTO > {
    var sessionTask : URLSessionTask?
    
    func initialize(requestDTO : LoginRequestDTO,completionHandler:@escaping(LoginResponseDTO?,Error?)->Void) {
        let baseUrl = Constants.baseURL
        let url = requestDTO.createGetRequestUrl(url: baseUrl)
        sessionTask?.cancel()
        if let params = requestDTO.createParamsDictionary()
        {
            sessionTask = super.getDataFromServerUsingPostWithJSONParams(url: url!, params: params, requestDto: requestDTO, completionHandler: completionHandler)
        }
        else
        {
            let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Invaild params"])
            completionHandler(nil,error)
        }
    }
    override func decode(data: Data) throws -> LoginResponseDTO {
        let decoder = JSONDecoder()
        return try decoder.decode(LoginResponseDTO.self, from: data)
    }
}
