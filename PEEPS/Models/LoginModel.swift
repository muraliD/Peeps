//
//  UserModel.swift
//  Investor Online
//
//  Created by Murali Dadi on 3/4/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit

class addpeepModel {
    //MARK: Properties
    
    
    var lName: String
    var fname:String
    var email:String
    var groupid:String
    var image:String
    init?(data:[String : AnyObject]) {
        
        // Initialize stored properties.
        self.fname = data["fName"] as! String
        self.lName = data["lName"] as! String
        self.email =  data["email"] as! String
        self.groupid = data["groupid"] as! String
        self.image = data["image"] as! String

        
    }

}


class addpeerModel {
    //MARK: Properties
    
    
    var pName: String
    var desc:String
    var image:String
    init?(data:[String : AnyObject]) {
        
        // Initialize stored properties.
        self.pName = data["pName"] as! String
        self.desc = data["desc"] as! String
        self.image = data["image"] as! String
        
        
    }
    
}
    







