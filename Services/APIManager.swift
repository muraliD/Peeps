//
//  APIManager.swift
//  Investor Online
//
//  Created by Murali Dadi on 3/4/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import SystemConfiguration


extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
class APIManager {
    
    static let sharedInstance = APIManager()
 
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
   
    

   
    func createBodyWithParameters(parameters: [String: String]?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
       
            let filename = "user-profile.jpg"
            let mimetype = "image/jpg"
            let filePathKey = "files"
            
            body.appendString(string:"--\(boundary)\r\n")
            body.appendString(string:"Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
            body.appendString(string:"Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageDataKey as Data)
            body.appendString(string: "\r\n")
     
       
        
        
        
        body.appendString(string:"--\(boundary)--\r\n")
        
        return body
    }
    
    
    
}
