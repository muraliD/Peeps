//
//  detpeepPeg.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 13, 2018

import Foundation

struct detpeepPeg : Codable {

        let nodes : [detpeepNode]?
        let peg : String?

        enum CodingKeys: String, CodingKey {
                case nodes = "nodes"
                case peg = "peg"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                nodes = try values.decodeIfPresent([detpeepNode].self, forKey: .nodes)
                peg = try values.decodeIfPresent(String.self, forKey: .peg)
        }

}
