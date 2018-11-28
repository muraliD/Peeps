//
//  signupResponseData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 14, 2018

import Foundation

struct signupResponseData : Codable {

        let id : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(String.self, forKey: .id)
        }

}
