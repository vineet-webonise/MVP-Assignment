//
//  NetworkConnectionHandler.swift
//  MVP_MVVM_Assignment
//
//  Created by admin on 22/09/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

protocol NetworkConnectionHandlerDelegate {
    func networkConnectionFinishedSuccessfully(responseObject: AnyObject, tag: NSInteger)
    func networkConnectionDidFailWithError(errorMessage:String, tag: NSInteger)
    func networkRequestRejected(errorMessage:String, tag: NSInteger)
    func networkStatusInactive()
}

class NetworkConnectionHandler: NSObject {
    
    var networkDelegate: NetworkConnectionHandlerDelegate!
    
    func sendErrorToSender(response: AnyObject, tag: NSInteger) {
        networkDelegate?.networkConnectionDidFailWithError(errorMessage: response.value(forKey:"message") as! String, tag: tag)
    }
    
    func sendResponseToSender(response: AnyObject, tag: NSInteger) {
        if (response.value(forKey:"status") as! NSInteger == 200) {
            networkDelegate?.networkConnectionFinishedSuccessfully(responseObject: response, tag: tag)
        }
        else {
            networkDelegate?.networkRequestRejected(errorMessage: response.value(forKey:"message") as! String, tag: tag)
        }
    }
    
    func getRequestBodyWithRequestType(requestType: String, forURL: NSURL, parameters: NSDictionary) -> NSMutableURLRequest {
        
        let request = NSMutableURLRequest(url: forURL as URL)
        request.httpMethod = requestType
        //let dataParameters : NSData = NSKeyedArchiver.archivedDataWithRootObject(parameters)
        //request.HTTPBody = dataParameters
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.setValue("Token XXXXXXX", forHTTPHeaderField:"Authorization")
        return request
    }
    
    func callWebServiceForSession(session: URLSession, request: NSMutableURLRequest, withTag: NSInteger) {
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    self.sendResponseToSender(response: jsonDictionary, tag: withTag)
                }
            }
            catch let error as NSError {
                print(error.localizedDescription)
                self.sendErrorToSender(response: response!, tag: withTag)
            }
        }
        task.resume()
    }
    
    func getUserList(withTag: NSInteger) {
        
        let url:NSURL = NSURL(string: "https://jsonplaceholder.typicode.com/comments")!
        let session = URLSession.shared
        let request = self.getRequestBodyWithRequestType(requestType: "GET", forURL: url, parameters: [:])
        callWebServiceForSession(session: session, request: request, withTag: withTag)
    }
    
   }
