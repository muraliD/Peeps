//
//  Config.swift
//  NARAYANI STEELS
//
//  Created by Murali Dadi on 4/20/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit

struct APPURL {

    private struct Domains {
        static let Dev = "http://api.getpeeps.com"
        static let UAT = ""
        static let Local = ""
        static let QA = ""
    }
    private struct Headers {
        static let FormData = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        static let urlencoded = ""
        static let json = ""

    }
    
    private  struct Routes {
        
        static let loginRouteApi = "/user/login"
        static let registerRouteApi = "/user/signup"
        static let forgotpasswordRouteApi = "/user/forgotpassword"
        static let detailsRouteApi = "/user/details"
        static let peepsRouteApi = "/user/peeps"
        static let dpeepsRouteApi = "/peeps"
        static let interactRouteApi = "/interact"
        static let peepsearchRouteApi = "/peepsearch"
        static let addnodeRouteApi = "/addnode"
        static let editnodeRouteApi = "/editnode"
     
         static let locknodeRouteApi = "/locknode"
         static let likenodeRouteApi = "/likenode"
         static let peerpeepsRouteApi = "/peerpeeps"
         static let peerpeepssearchRouteApi = "/peerpeeps/search"
         static let peerpeepsaddRouteApi = "/peerpeeps/add"
        
         static let peepflownodeRouteApi = "/peepflow/node"
         static let peepflowsearchRouteApi = "/peepflow/search"
         static let peepgopopupRouteApi = "/peepgo/popup"
        
         static let generatepegsRouteApi = "/generatepegs"
         static let saveinteractimageRouteApi = "/saveinteractimage"
         static let admingroupslistRouteApi = "/admingroups/list"

   static let admingroupdownloadRouteApi = "/admingroup/download"
         static let socialsignupRouteApi = "/user/socialsignup"
   

    }
   
    private  static let Domain = Domains.Dev
    static var header = Headers.FormData
    
    private  static let Routelogin = Routes.loginRouteApi
    private  static let Routeregister = Routes.registerRouteApi
      private  static let Routeadmingroupslist = Routes.admingroupslistRouteApi
     private  static let Routeadmingroupdownload = Routes.admingroupdownloadRouteApi
    private  static let Routesocialsignup = Routes.socialsignupRouteApi
    private  static let Routeforgotpassword = Routes.forgotpasswordRouteApi
   
     private  static let Routedetails = Routes.detailsRouteApi
    
     private  static let Routepeeps = Routes.peepsRouteApi
   private  static let Routedpeeps = Routes.dpeepsRouteApi
    
      private  static let interactpeeps = Routes.interactRouteApi
    
     static let Routepeepsearch = Routes.peepsearchRouteApi
      static let Routeaddnode = Routes.addnodeRouteApi
    
    static let Routelocknode = Routes.locknodeRouteApi
    static let Routelikenode = Routes.likenodeRouteApi
    static let Routeeditnode = Routes.editnodeRouteApi
     static let Routesaveinteractimage = Routes.saveinteractimageRouteApi
    
    
    static let Routepeerpeeps = Routes.peerpeepsRouteApi
    static let Routepeerpeepssearch = Routes.peerpeepssearchRouteApi
     static let Routepeerpeepsadd = Routes.peerpeepsaddRouteApi
    
    
       static let Routepeepflownode = Routes.peepflownodeRouteApi
       static let Routepeepflowsearch = Routes.peepflowsearchRouteApi
       static let Routepeepgopopup = Routes.peepgopopupRouteApi
    
    static let Routegeneratepegs = Routes.generatepegsRouteApi
    
    
    
    static var loginApi: String {
        return Domain  + Routelogin
    }
    static var registerApi: String {
        return Domain  + Routeregister
    }
    static var forgotpasswordApi: String {
        return Domain  + Routeforgotpassword
    }
    static var detailsApi: String {
        return Domain  + Routedetails
    }
    static var peepsApi: String {
        return Domain  + Routepeeps
    }
    static var dpeepsApi: String {
        return Domain  + Routedpeeps
    }
    static var interactApi: String {
        return Domain  + interactpeeps
    }
    
    static var peepsearchApi: String {
        return Domain  + Routepeepsearch
    }
    static var addnodeApi: String {
        return Domain  + Routeaddnode
    }
    static var editnodeApi: String {
        return Domain  + Routeeditnode
    }
    static var locknodeApi: String {
        return Domain  + Routelocknode
    }
    static var likenodeApi: String {
        return Domain  + Routelikenode
    }
    static var peerpeepsApi: String {
        return Domain  + Routepeerpeeps
    }
    static var peerpeepssearchApi: String {
        return Domain  + Routepeerpeepssearch
    }
    static var peerpeepsaddApi: String {
        return Domain  + Routepeerpeepsadd
    }
    
    static var peepflownodeApi: String {
        return Domain  + Routepeepflownode
    }
    
    static var peepflowsearchApi: String {
        return Domain  + Routepeepflowsearch
    }
    
    static var peepgopopupRouteApi: String {
        return Domain  + Routepeepgopopup
    }
    static var generatepegsRouteApi: String {
        return Domain  + Routegeneratepegs
    }
    
    static var saveinteractimageRouteApi: String {
        return Domain  + Routesaveinteractimage
    }
    
    static var admingroupslistRouteApi: String {
        return Domain  + Routeadmingroupslist
    }
    
    static var admingroupdownloadRouteApi: String {
        return Domain  + Routeadmingroupdownload
    }
    
    static var socialsignupRouteApi: String {
        return Domain  + Routesocialsignup
    }
    
  
    
}

