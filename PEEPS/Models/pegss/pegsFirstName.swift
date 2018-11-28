//
//  pegsFirstName.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 29, 2018

import Foundation

struct pegsFirstName : Codable {

        let node : String?
        let peg : String?

        enum CodingKeys: String, CodingKey {
                case node = "node"
                case peg = "peg"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                node = try values.decodeIfPresent(String.self, forKey: .node)
                peg = try values.decodeIfPresent(String.self, forKey: .peg)
        }

}
