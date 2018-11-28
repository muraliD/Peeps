//
//  flown1RootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2018

import Foundation

struct flown1RootClass : Codable {

        let nodes : [flown1Node]?
        let peep : flown1Peep?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case nodes = "nodes"
                case peep = "peep"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                nodes = try values.decodeIfPresent([flown1Node].self, forKey: .nodes)
                peep = try values.decodeIfPresent(flown1Peep.self, forKey: .peep)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}
