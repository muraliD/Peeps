//
//  peepdetRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 16, 2018

import Foundation

struct peepdetRootClass : Codable {

        let peepDetails : [peepdetPeepDetail]?
        let pegs : [peepdetPeg]?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case peepDetails = "peepDetails"
                case pegs = "pegs"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                peepDetails = try values.decodeIfPresent([peepdetPeepDetail].self, forKey: .peepDetails)
                pegs = try values.decodeIfPresent([peepdetPeg].self, forKey: .pegs)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}
