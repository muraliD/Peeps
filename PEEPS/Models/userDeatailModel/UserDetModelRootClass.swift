//
//  UserDetModelRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 14, 2018

import Foundation

struct UserDetModelRootClass : Codable {

        let success : Bool?
        let userDetails : [UserDetModelUserDetail]?

        enum CodingKeys: String, CodingKey {
                case success = "success"
                case userDetails = "userDetails"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
                userDetails = try values.decodeIfPresent([UserDetModelUserDetail].self, forKey: .userDetails)
        }

}
