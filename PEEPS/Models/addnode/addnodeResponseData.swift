//
//  addnodeResponseData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 4, 2018

import Foundation

struct addnodeResponseData : Codable {

        let nodeId : String?

        enum CodingKeys: String, CodingKey {
                case nodeId = "nodeId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                nodeId = try values.decodeIfPresent(String.self, forKey: .nodeId)
        }

}
