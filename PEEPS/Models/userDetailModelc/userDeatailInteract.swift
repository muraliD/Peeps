//
//  userDeatailInteract.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 13, 2018

import Foundation

struct userDeatailInteract : Codable {

        let firstName : String?
        let image : String?
        let interactImage : String?
        let lastName : String?
        let peepId : String?

        enum CodingKeys: String, CodingKey {
                case firstName = "firstName"
                case image = "image"
                case interactImage = "interactImage"
                case lastName = "lastName"
                case peepId = "peepId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                image = try values.decodeIfPresent(String.self, forKey: .image)
                interactImage = try values.decodeIfPresent(String.self, forKey: .interactImage)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                peepId = try values.decodeIfPresent(String.self, forKey: .peepId)
        }

}
