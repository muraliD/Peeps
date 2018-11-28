//
//  addnodeRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 4, 2018

import Foundation

struct addnodeRootClass : Codable {

        let responseData : addnodeResponseData?
        let success : Bool?
 let message : String?
        enum CodingKeys: String, CodingKey {
                case responseData = "responseData"
                case success = "success"
             case message = "message"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                responseData = try values.decodeIfPresent(addnodeResponseData.self, forKey: .responseData)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
             message = try values.decodeIfPresent(String.self, forKey: .message)
        }

}



