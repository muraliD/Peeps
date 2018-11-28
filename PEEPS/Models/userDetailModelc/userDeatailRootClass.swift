//
//  userDeatailRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 13, 2018

import Foundation

struct userDeatailRootClass : Codable {

        let success : Bool?
        let userDetails : [userDeatailUserDetail]?

        enum CodingKeys: String, CodingKey {
                case success = "success"
                case userDetails = "userDetails"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
                userDetails = try values.decodeIfPresent([userDeatailUserDetail].self, forKey: .userDetails)
        }

}
