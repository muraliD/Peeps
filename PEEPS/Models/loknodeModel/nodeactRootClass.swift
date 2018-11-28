//
//  nodeactRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 5, 2018

import Foundation

struct nodeactRootClass : Codable {

        let responseData : nodeactResponseData?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case responseData = "responseData"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                responseData = try values.decodeIfPresent(nodeactResponseData.self, forKey: .responseData)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}
