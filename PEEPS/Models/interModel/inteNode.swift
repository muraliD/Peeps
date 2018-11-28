//
//  inteNode.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 17, 2018

import Foundation

struct inteNode : Codable {

        let createdAt : String?
        let descriptionField : String?
        let id : String?
        let image : String?
        let node : String?
        let peepId : String?
        let sound : String?
        let userId : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "createdAt"
                case descriptionField = "description"
                case id = "id"
                case image = "image"
                case node = "node"
                case peepId = "peepId"
                case sound = "sound"
                case userId = "userId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                image = try values.decodeIfPresent(String.self, forKey: .image)
                node = try values.decodeIfPresent(String.self, forKey: .node)
                peepId = try values.decodeIfPresent(String.self, forKey: .peepId)
                sound = try values.decodeIfPresent(String.self, forKey: .sound)
                userId = try values.decodeIfPresent(String.self, forKey: .userId)
        }

}
