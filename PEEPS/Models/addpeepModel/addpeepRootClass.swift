//
//  addpeepRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 6, 2018

import Foundation

struct addpeepRootClass : Codable {

        let message : String?
   
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case message = "message"
              
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                message = try values.decodeIfPresent(String.self, forKey: .message)
            
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}
