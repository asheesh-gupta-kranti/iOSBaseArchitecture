//
//  BaseRequestUseCase.swift
//  BaseArchitecture
//
//  Created by Ashutosh Mishra on 30/08/18.
//  Copyright © 2018 i2e1. All rights reserved.
//

import UIKit

protocol BaseRequestDTO {
    func createGetRequestUrl(url:String)-> URL?
}

protocol BaseResponseDTO {
    
}

class BaseRequestUseCase <S : BaseRequestDTO ,T : BaseResponseDTO > {
    
    func initialize(requestDTO : S)  {
        fatalError("This is an Abstract Base class, Method should be override")
        
    }
    func getDataFromServerUsingGet(url : URL, requestDto:S, completionHandler:@escaping(T? , Error?) -> Void) -> URLSessionTask{
        
        return NetworkManager.shared.getData(url:url) { (data, error) in
            if let error = error  {
                DispatchQueue.main.async {
                    completionHandler(nil , error)
                }
            }else{
                guard let unwrappedData = data else {
                    DispatchQueue.main.async {
                        completionHandler(nil,nil);
                    }
                    return
                }
                do {
                    let response = try self.decode(data: unwrappedData)
                    DispatchQueue.main.async {
                        completionHandler(response,nil)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completionHandler(nil,error)
                    }
                }
            }
        }
    }
    
    func getDataFromServerUsingPostWithJSONParams(url : URL, params : [String : String], requestDto:S, completionHandler:@escaping(T? , Error?) -> Void) -> URLSessionTask{
        
        return NetworkManager.shared.postDataWithJSONParams(url:url, params: params) { (data, error) in
            if let error = error  {
                DispatchQueue.main.async {
                    completionHandler(nil , error)
                }
            }else{
                guard let unwrappedData = data else {
                    DispatchQueue.main.async {
                        completionHandler(nil,nil);
                    }
                    return
                }
                do {
                    let response = try self.decode(data: unwrappedData)
                    DispatchQueue.main.async {
                        completionHandler(response,nil)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completionHandler(nil,error)
                    }
                }
            }
            
        }
        
    }
    
    func getDataFromServerUsingPut(url : URL, params : [String : String], requestDto:S, completionHandler:@escaping(T? , Error?) -> Void) -> URLSessionTask{
        
        return NetworkManager.shared.putDataWithJSONParams(url:url, params: params) { (data, error) in
            if let error = error  {
                DispatchQueue.main.async {
                    completionHandler(nil , error)
                }
            }else{
                guard let unwrappedData = data else {
                    DispatchQueue.main.async {
                        completionHandler(nil,nil);
                    }
                    return
                }
                do {
                    let response = try self.decode(data: unwrappedData)
                    DispatchQueue.main.async {
                        completionHandler(response,nil)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completionHandler(nil,error)
                    }
                }
            }
            
        }
        
    }
    
    func decode(data : Data)throws -> T {
        fatalError("This is an Abstract Base class, Method should be override")
    }
}
