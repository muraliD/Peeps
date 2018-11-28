//
//  flown2Peep.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2018

import Foundation

struct flown2Peep : Codable {

        let firstName : String?
        let lastName : String?
        let profilePic : String?

        enum CodingKeys: String, CodingKey {
                case firstName = "firstName"
                case lastName = "lastName"
                case profilePic = "profilePic"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
        }

}

