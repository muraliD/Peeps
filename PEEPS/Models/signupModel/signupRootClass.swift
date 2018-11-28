//
//  signupRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 14, 2018

import Foundation

struct signupRootClass : Codable {

        let message : String?
        let reason : String?
        let responseData : signupResponseData?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case message = "message"
                case reason = "reason"
                case responseData = "responseData"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                reason = try values.decodeIfPresent(String.self, forKey: .reason)
               responseData = try values.decodeIfPresent(signupResponseData.self, forKey: .responseData)
            
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}
