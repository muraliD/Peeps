//
//  peergrpRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2018

import Foundation

struct peergrpRootClass : Codable {

        let groupCount : Int?
        let message : String?
        let responseData : [peergrpResponseData]?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case groupCount = "groupCount"
                case message = "message"
                case responseData = "responseData"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                groupCount = try values.decodeIfPresent(Int.self, forKey: .groupCount)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                responseData = try values.decodeIfPresent([peergrpResponseData].self, forKey: .responseData)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}
