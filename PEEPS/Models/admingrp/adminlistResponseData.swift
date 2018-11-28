//
//  adminlistResponseData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 20, 2018

import Foundation

struct adminlistResponseData : Codable {

        let createdAt : String?
        let descriptionField : String?
        let groupOwner : String?
        let id : String?
        let image : String?
        let name : String?
        let ownerType : String?
        let peepsCount : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "createdAt"
                case descriptionField = "description"
                case groupOwner = "groupOwner"
                case id = "id"
                case image = "image"
                case name = "name"
                case ownerType = "ownerType"
                case peepsCount = "peepsCount"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
                groupOwner = try values.decodeIfPresent(String.self, forKey: .groupOwner)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                image = try values.decodeIfPresent(String.self, forKey: .image)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                ownerType = try values.decodeIfPresent(String.self, forKey: .ownerType)
                peepsCount = try values.decodeIfPresent(String.self, forKey: .peepsCount)
        }

}
