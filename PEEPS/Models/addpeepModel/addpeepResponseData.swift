//
//  addpeepResponseData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 6, 2018

import Foundation

struct addpeepResponseData : Codable {

        let peepId : String?

        enum CodingKeys: String, CodingKey {
                case peepId = "peepId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                peepId = try values.decodeIfPresent(String.self, forKey: .peepId)
        }

}
