//
//  userDeatailUserDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 13, 2018

import Foundation

struct userDeatailUserDetail : Codable {

        let aboutMe : String?
        let createdAt : String?
        let email : String?
        let firstName : String?
        let id : String?
        let interacts : [userDeatailInteract]?
        let lastName : String?
        let peepCount : Int?
        let profilePic : String?

        enum CodingKeys: String, CodingKey {
                case aboutMe = "aboutMe"
                case createdAt = "createdAt"
                case email = "email"
                case firstName = "firstName"
                case id = "id"
                case interacts = "interacts"
                case lastName = "lastName"
                case peepCount = "peepCount"
                case profilePic = "profilePic"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                aboutMe = try values.decodeIfPresent(String.self, forKey: .aboutMe)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                interacts = try values.decodeIfPresent([userDeatailInteract].self, forKey: .interacts)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                peepCount = try values.decodeIfPresent(Int.self, forKey: .peepCount)
                profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
        }

}
