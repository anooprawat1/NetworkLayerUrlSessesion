//
//  ApiManager.swift
//  NetworkLayerURLSession
//
//  Created by Anoop Rawat on 26/02/17.
//  Copyright © 2017 Anoop Rawat. All rights reserved.
//

import UIKit

// For Error Handling you can define errors here

public enum Result {
    case responseData([String:Any])
    case error(Error)
}

// Completion Block
typealias completionBlock = (Result) -> Void

// Api Manager class will be the single source connection to network

class ApiManager: NSObject {
    
    static let sharedInstance = ApiManager()   // Singleton Class
    
  
  
    let urlSession:URLSession = {
        let config = URLSessionConfiguration.default // Session Configuration
        config.timeoutIntervalForRequest = 60.0
        let session = URLSession(configuration: config) // Load configuration into Session
       return session
    }()
    
    // Method for Get request
    func apiGetRequerst(urlString:String,parameter:[String:AnyObject]?,completionHandler:@escaping completionBlock)  {
        let combineUrl = ServiceApi.baseUrl+urlString
        
        guard let url = NSURL(string:combineUrl) else {
            return
        }
        let task = urlSession.dataTask(with: url as URL) { (data, response, error) in
            
            guard error == nil, let json = self.jsonSerializationWithData(data: data)
                else {
                    completionHandler(Result.error(error!)); return
            }
            completionHandler(Result.responseData(json))
        }
        
        task.resume()
        
    }
    
    // Like above you can add methods for Post request Or Upload request or Download Request
    func apiPostRequest(urlString:String,parameter:[String:AnyObject]?,completionHandler:@escaping completionBlock)  {
        
    }
    
    func apiForUploadingRequest(urlString:String,parameter:[String:AnyObject]?,completionHandler:@escaping completionBlock) {
        
    }
    
    func apiForDownloadingRequest(urlString:String,parameter:[String:AnyObject]?,completionHandler:@escaping completionBlock) {
        
    }
    
    // Method for json Serialaization
   private func jsonSerializationWithData(data:Data?) -> [String:Any]? {
        guard (data != nil) else {
            return nil
        }
        do
        {
             return try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
        }
        catch
        {
             print("error in JSONSerialization")
        }
        return nil
        
    }
    
    // You can create a common method for Error Handling
//    private func errorHandling(error:String) -> String{
//    
//    }
//    
//    
}
