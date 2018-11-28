//
//  flown3Option.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2018

import Foundation

struct flown3Option : Codable {

        let correctAnswer : Bool?
        let id : String?
        let profilePic : String?
        var ischeck : Bool?
    

        enum CodingKeys: String, CodingKey {
                case correctAnswer = "correctAnswer"
                case id = "id"
                case profilePic = "profilePic"
             case ischeck = "ischeck"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                correctAnswer = try values.decodeIfPresent(Bool.self, forKey: .correctAnswer)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
                 ischeck = try values.decodeIfPresent(Bool.self, forKey: .ischeck)
        }

}
