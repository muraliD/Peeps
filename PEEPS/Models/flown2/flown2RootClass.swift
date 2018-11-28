//
//  flown2RootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2018

import Foundation

struct flown2RootClass : Codable {

        let options : flown2Option?
        let peep : flown2Peep?
        let success : Bool?

        enum CodingKeys: String, CodingKey {
                case options = "options"
                case peep = "peep"
                case success = "success"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                options = try values.decodeIfPresent(flown2Option.self, forKey: .options)
                peep = try values.decodeIfPresent(flown2Peep.self, forKey: .peep)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }

}



