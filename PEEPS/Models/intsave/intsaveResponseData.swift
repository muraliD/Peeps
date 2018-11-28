//
//  intsaveResponseData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 20, 2018

import Foundation

struct intsaveResponseData : Codable {

        let interactId : String?

        enum CodingKeys: String, CodingKey {
                case interactId = "interactId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                interactId = try values.decodeIfPresent(String.self, forKey: .interactId)
        }

}
