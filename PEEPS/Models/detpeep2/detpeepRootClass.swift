//
//  detpeepRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 13, 2018

import Foundation

struct detpeepRootClass : Codable {

        let peepDetails : [detpeepPeepDetail]?
        let pegs : [detpeepPeg]?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case peepDetails = "peepDetails"
                case pegs = "pegs"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                peepDetails = try values.decodeIfPresent([detpeepPeepDetail].self, forKey: .peepDetails)
                pegs = try values.decodeIfPresent([detpeepPeg].self, forKey: .pegs)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}
