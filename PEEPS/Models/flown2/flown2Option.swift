//
//  flown2Option.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2018

import Foundation

struct flown2Option : Codable {
    
    let firstName : [String]?
    let lastName : [String]?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent([String].self, forKey: .firstName)
        lastName = try values.decodeIfPresent([String].self, forKey: .lastName)
    }
    
}
