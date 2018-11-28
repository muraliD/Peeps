//
//  pegsRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 29, 2018

import Foundation

struct pegsRootClass : Codable {

        let responseData : pegsResponseData?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case responseData = "responseData"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                responseData = try values.decodeIfPresent(pegsResponseData.self, forKey: .responseData)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}



