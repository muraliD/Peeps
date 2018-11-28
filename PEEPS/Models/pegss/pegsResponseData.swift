//
//  pegsResponseData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 29, 2018

import Foundation

struct pegsResponseData : Codable {

        let firstName : [pegsFirstName]?
        let lastName : [pegsLastName]?

        enum CodingKeys: String, CodingKey {
                case firstName = "firstName"
                case lastName = "lastName"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                firstName = try values.decodeIfPresent([pegsFirstName].self, forKey: .firstName)
                lastName = try values.decodeIfPresent([pegsLastName].self, forKey: .lastName)
        }

}
