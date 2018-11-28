//
//  flown3RootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2018

import Foundation

struct flown3RootClass : Codable {

        let options : [flown3Option]?
        let question : String?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case options = "options"
                case question = "question"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                options = try values.decodeIfPresent([flown3Option].self, forKey: .options)
                question = try values.decodeIfPresent(String.self, forKey: .question)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}
