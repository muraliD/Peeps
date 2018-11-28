//
//  peepdetPeg.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 16, 2018

import Foundation

struct peepdetPeg : Codable {

        let nodes : [peepdetNode]?
        let peg : String?

        enum CodingKeys: String, CodingKey {
                case nodes = "nodes"
                case peg = "peg"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                nodes = try values.decodeIfPresent([peepdetNode].self, forKey: .nodes)
                peg = try values.decodeIfPresent(String.self, forKey: .peg)
        }

}
