//
//  intsaveRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 20, 2018

import Foundation

struct intsaveRootClass : Codable {

        let message : String?
        let responseData : intsaveResponseData?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case message = "message"
                case responseData = "responseData"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                responseData = try values.decodeIfPresent(intsaveResponseData.self, forKey: .responseData)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}

