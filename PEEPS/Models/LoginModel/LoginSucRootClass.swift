//
//  LoginSucRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 1, 2018

import Foundation

struct LoginSucRootClass : Codable {

        let message : String?
        let responseData : LoginSucResponseData?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case message = "message"
                case responseData = "responseData"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                responseData = try values.decodeIfPresent(LoginSucResponseData.self, forKey: .responseData)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}
