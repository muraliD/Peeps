//
//  peepdetNode.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 16, 2018

import Foundation

struct peepdetNode : Codable {

        let createdAt : String?
        let descriptionField : String?
        let id : String?
        let image : String?
        let isLiked : String?
        let isLocked : String?
        let peepId : String?
        let peg : String?
        let sound : String?
        let userId : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "createdAt"
                case descriptionField = "description"
                case id = "id"
                case image = "image"
                case isLiked = "isLiked"
                case isLocked = "isLocked"
                case peepId = "peepId"
                case peg = "peg"
                case sound = "sound"
                case userId = "userId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                image = try values.decodeIfPresent(String.self, forKey: .image)
                isLiked = try values.decodeIfPresent(String.self, forKey: .isLiked)
                isLocked = try values.decodeIfPresent(String.self, forKey: .isLocked)
                peepId = try values.decodeIfPresent(String.self, forKey: .peepId)
                peg = try values.decodeIfPresent(String.self, forKey: .peg)
                sound = try values.decodeIfPresent(String.self, forKey: .sound)
                userId = try values.decodeIfPresent(String.self, forKey: .userId)
        }

}
