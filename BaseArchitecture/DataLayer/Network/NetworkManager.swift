//
//  NetworkManager.swift
//  BaseArchitecture
//
//  Created by Ashutosh Mishra on 30/08/18.
//  Copyright © 2018 i2e1. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    enum URLError : Error {
        case URLISNIL
        case URLBadScheme
    }
    
    struct NetworkError : Error {
        var errorCode : String
        var errorType : String
    }
    
    static var shared = NetworkManager()
    private override init() {
        super.init()
        
    }
    
    private lazy var queue : OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
    
    private lazy var session : URLSession = {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: self.queue)
        return  session
    }()
    
    func getData(url : URL , completionHandler:@escaping(Data? , Error?)->Void) -> URLSessionTask
    {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
       
        let sessionTask = self.session.dataTask(with: request) { (data, response, error) in
            completionHandler(data,error)
        }
        sessionTask.resume()
        return sessionTask
        
    }
    
    func postDataWithJSONParams(url : URL , params : [String : String], completionHandler:@escaping(Data? , Error?)->Void) -> URLSessionTask {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var jsonData : Data = Data()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
        } catch {
            completionHandler(nil,error)
        }
        request.httpBody = jsonData
        let sessionTask = self.session.dataTask(with: request) { (data, response, error) in
            
            let backToString = String(data: data!, encoding: String.Encoding.utf8) as String?
            print(backToString ?? "")
            completionHandler(data,error)
        }
        sessionTask.resume()
        return sessionTask
    }
    
    func putDataWithJSONParams(url : URL , params : [String : String], completionHandler:@escaping(Data? , Error?)->Void) -> URLSessionTask {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var jsonData : Data = Data()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
        } catch {
            completionHandler(nil,error)
        }
        request.httpBody = jsonData
        let sessionTask = self.session.dataTask(with: request) { (data, response, error) in
            
            let backToString = String(data: data!, encoding: String.Encoding.utf8) as String?
            print(backToString ?? "")
            completionHandler(data,error)
        }
        sessionTask.resume()
        return sessionTask
    }
    
}
