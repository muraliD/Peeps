//
//  loginResponseData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 14, 2018

import Foundation

struct loginResponseData : Codable {

        let aboutMe : String?
        let createdAt : String?
        let deletedAt : String?
        let deviceId : String?
        let email : String?
        let firstName : String?
        let id : String?
        let isActive : String?
        let lastLogin : String?
        let lastName : String?
        let os : String?
        let points : String?
        let profilePic : String?
        let updatedAt : String?
        let username : String?

        enum CodingKeys: String, CodingKey {
                case aboutMe = "aboutMe"
                case createdAt = "createdAt"
                case deletedAt = "deletedAt"
                case deviceId = "deviceId"
                case email = "email"
                case firstName = "firstName"
                case id = "id"
                case isActive = "isActive"
                case lastLogin = "lastLogin"
                case lastName = "lastName"
                case os = "os"
                case points = "points"
                case profilePic = "profilePic"
                case updatedAt = "updatedAt"
                case username = "username"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                aboutMe = try values.decodeIfPresent(String.self, forKey: .aboutMe)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
                deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
                lastLogin = try values.decodeIfPresent(String.self, forKey: .lastLogin)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                os = try values.decodeIfPresent(String.self, forKey: .os)
                points = try values.decodeIfPresent(String.self, forKey: .points)
                profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                username = try values.decodeIfPresent(String.self, forKey: .username)
        }

}
