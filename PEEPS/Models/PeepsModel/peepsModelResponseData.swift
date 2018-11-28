//
//  peepsModelResponseData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 14, 2018

import Foundation

struct peepsModelResponseData : Codable {

        let aboutMe : String?
        let createdAt : String?
        let email : String?
        let firstName : String?
        let lastName : String?
        let profilePic : String?
        let id:String?
        var ischeck:Bool?

        enum CodingKeys: String, CodingKey {
                case aboutMe = "aboutMe"
                case createdAt = "createdAt"
                case email = "email"
                case firstName = "firstName"
                case lastName = "lastName"
                case profilePic = "profilePic"
            case ischeck = "ischeck"
            
            case id = "id"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                aboutMe = try values.decodeIfPresent(String.self, forKey: .aboutMe)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
             ischeck = try values.decodeIfPresent(Bool.self, forKey: .ischeck)
             id = try values.decodeIfPresent(String.self, forKey: .id)
        }

}
