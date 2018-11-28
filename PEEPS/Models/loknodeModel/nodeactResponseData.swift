//
//  nodeactResponseData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 5, 2018

import Foundation

struct nodeactResponseData : Codable {

        let lockedNodeId : String?
 let likedId : String?
        enum CodingKeys: String, CodingKey {
                case lockedNodeId = "lockedNodeId"
              case likedId = "likedId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                lockedNodeId = try values.decodeIfPresent(String.self, forKey: .lockedNodeId)
            likedId = try values.decodeIfPresent(String.self, forKey: .likedId)
        }

}
