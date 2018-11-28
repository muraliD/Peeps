//
//  inteRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 17, 2018

import Foundation

struct inteRootClass : Codable {

        let nodes : [inteNode]?
        let peepDetails : [intePeepDetail]?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case nodes = "nodes"
                case peepDetails = "peepDetails"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                nodes = try values.decodeIfPresent([inteNode].self, forKey: .nodes)
                peepDetails = try values.decodeIfPresent([intePeepDetail].self, forKey: .peepDetails)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}
