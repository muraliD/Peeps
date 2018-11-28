//
//  peepdetPeepDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 16, 2018

import Foundation

struct peepdetPeepDetail : Codable {

        let aboutMe : String?
        let createdAt : String?
        let email : String?
        let firstName : String?
        let id : String?
        let lastName : String?
        let profilePic : String?

        enum CodingKeys: String, CodingKey {
                case aboutMe = "aboutMe"
                case createdAt = "createdAt"
                case email = "email"
                case firstName = "firstName"
                case id = "id"
                case lastName = "lastName"
                case profilePic = "profilePic"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                aboutMe = try values.decodeIfPresent(String.self, forKey: .aboutMe)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
        }

}
