//
//  LoginSucResponseData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 1, 2018

import Foundation

struct LoginSucResponseData : Codable {

        let aboutMe : String?
        let address : String?
        let age : String?
        let birthDate : String?
        let cityId : String?
        let countryId : String?
        let createdAt : String?
        let deletedAt : String?
        let deviceId : String?
        let email : String?
        let fiscalCode : String?
        let gender : String?
        let id : String?
        let isActive : String?
        let lastLogin : String?
        let lifestyleTypeId : String?
        let morpheTypeId : String?
        let name : String?
        let os : String?
        let phone : String?
        let planId : String?
        let points : String?
        let practiceSportsFlag : String?
        let profilePic : String?
        let pymentStatus : String?
        let sportsId : String?
        let surname : String?
        let updatedAt : String?
        let username : String?
        let userType : String?
        let weekTimes : String?

        enum CodingKeys: String, CodingKey {
                case aboutMe = "aboutMe"
                case address = "address"
                case age = "age"
                case birthDate = "birthDate"
                case cityId = "cityId"
                case countryId = "countryId"
                case createdAt = "createdAt"
                case deletedAt = "deletedAt"
                case deviceId = "deviceId"
                case email = "email"
                case fiscalCode = "fiscalCode"
                case gender = "gender"
                case id = "id"
                case isActive = "isActive"
                case lastLogin = "lastLogin"
                case lifestyleTypeId = "lifestyleTypeId"
                case morpheTypeId = "morpheTypeId"
                case name = "name"
                case os = "os"
                case phone = "phone"
                case planId = "planId"
                case points = "points"
                case practiceSportsFlag = "practiceSportsFlag"
                case profilePic = "profilePic"
                case pymentStatus = "pymentStatus"
                case sportsId = "sportsId"
                case surname = "surname"
                case updatedAt = "updatedAt"
                case username = "username"
                case userType = "userType"
                case weekTimes = "weekTimes"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                aboutMe = try values.decodeIfPresent(String.self, forKey: .aboutMe)
                address = try values.decodeIfPresent(String.self, forKey: .address)
                age = try values.decodeIfPresent(String.self, forKey: .age)
                birthDate = try values.decodeIfPresent(String.self, forKey: .birthDate)
                cityId = try values.decodeIfPresent(String.self, forKey: .cityId)
                countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
                deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                fiscalCode = try values.decodeIfPresent(String.self, forKey: .fiscalCode)
                gender = try values.decodeIfPresent(String.self, forKey: .gender)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
                lastLogin = try values.decodeIfPresent(String.self, forKey: .lastLogin)
                lifestyleTypeId = try values.decodeIfPresent(String.self, forKey: .lifestyleTypeId)
                morpheTypeId = try values.decodeIfPresent(String.self, forKey: .morpheTypeId)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                os = try values.decodeIfPresent(String.self, forKey: .os)
                phone = try values.decodeIfPresent(String.self, forKey: .phone)
                planId = try values.decodeIfPresent(String.self, forKey: .planId)
                points = try values.decodeIfPresent(String.self, forKey: .points)
                practiceSportsFlag = try values.decodeIfPresent(String.self, forKey: .practiceSportsFlag)
                profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
                pymentStatus = try values.decodeIfPresent(String.self, forKey: .pymentStatus)
                sportsId = try values.decodeIfPresent(String.self, forKey: .sportsId)
                surname = try values.decodeIfPresent(String.self, forKey: .surname)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                username = try values.decodeIfPresent(String.self, forKey: .username)
                userType = try values.decodeIfPresent(String.self, forKey: .userType)
                weekTimes = try values.decodeIfPresent(String.self, forKey: .weekTimes)
        }

}
