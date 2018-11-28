//
//  ViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 7/24/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import LSDialogViewController
import Alamofire
import FacebookCore
import FacebookLogin
import GoogleSignIn

import FBSDKLoginKit

extension UITextField {
    func setBottomBorder(img:String,placeholder:String) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
        let image =  UIImage(named: img)
        
        
        let myButton = UIButton(type: UIButtonType.custom)
        
        
        myButton.frame = CGRect(x: 25, y: 5, width: image!.size.width, height: image!.size.height)
        myButton.setImage(image, for: .normal)
        
        
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        
        paddingView.addSubview(myButton)
        self.rightViewMode = .always
        self.rightView = paddingView
        self.placeholder = placeholder
        
        
        
        
        
    }
}
class ViewController: UIViewController,SecondVCDelegate,GIDSignInDelegate,GIDSignInUIDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        var uname = ""
        var fname = ""
        var lname = ""
        var email = ""
        
        
        
        if (error == nil) {
            // Perform any operations on signed in user here.
//            let userId = user.userID                  // For client-side use only!
//            let idToken = user.authentication.idToken // Safe to send to the server
//            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
//            let email = user.profile.email
//            let image = user.profile.imageURL(withDimension: 100)
           
            
            if let name = user.profile.name {
                uname = name
            }
            if let name = user.profile.familyName {
                lname = name
            }
            if let name = user.profile.givenName {
                fname = name
            }
            if let emails = user.profile.email {
                email = emails
            }
            
            if(email.count>0){
                let parameters:[String: Any] = ["firstname":fname,"lastname":lname,"username":uname,"email":email,"deviceId":"1234565","os":"ios"]
                
                self.socialsignup(parameters: parameters);
                
            }else{
                self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Email should required");
            }
            
            
           
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
//   @IBOutlet weak var signInButton: GIDSignInButton!
     @IBAction func signInButtonAct(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
   
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func fbloginAct(_ sender: Any) {

//        var parameters:[String: Any] = [:]
        JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
         var uname = ""
         var fname = ""
         var lname = ""
         var email = ""
       
        
            let loginManager = appDelegate?.loginManager
        loginManager!.logIn(readPermissions: [.publicProfile,.email,.userFriends], viewController: self) { result in
                switch result{
                case .cancelled:
                    JustHUD.shared.hide()
                    print("Cancel button click")
                case .success:
                    let params = ["fields" : "id, name, first_name, last_name, picture.type(large), email "]
                    let graphRequest = FBSDKGraphRequest.init(graphPath: "/me", parameters: params)
                    let Connection = FBSDKGraphRequestConnection()
                    Connection.add(graphRequest) { (Connection, result, error) in
                        
                        let info = result as! [String : AnyObject]
                        print(info["name"] as! String)
                        
                        if let name = info["name"] {
                            uname = name as! String
                        }
                        if let name = info["last_name"] {
                            lname = name as! String
                        }
                        if let name = info["first_name"] {
                            fname = name as! String
                        }
                        if let emails = info["email"] {
                            email = emails as! String
                        }
                        
                        if(email.count>0){
                            let parameters:[String: Any] = ["firstname":fname,"lastname":lname,"username":uname,"email":email,"deviceId":"1234565","os":"ios"]
                            
                            self.socialsignup(parameters: parameters);
                            
                        }else{
                              self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Email should required");
                        }
                        
                     
                        
                        
                        
                        
                    }
                    Connection.start()
                default:
                    print("??")
                }
            }
     
        
        
        
        
        
    }
    
    func socialsignup(parameters:[String: Any] ){
       
        JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request(APPURL.socialsignupRouteApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
               
                
                
                do {
                    let homrres:loginRootClass = try JSONDecoder().decode(loginRootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        
                        let resData:loginResponseData =  homrres.responseData!
                        var userid = ""
                        if let id = resData.id {
                            userid = id
                        }
                        UserDefaults.standard.set(userid, forKey:"uid")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
                        
                        
                        self.present(vc, animated: true, completion: nil)
                        
                        
                    }else{
                        
                        GIDSignIn.sharedInstance().signOut()
                        
                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                        JustHUD.shared.hide()
                        
                    }
                    
                } catch {
                    print(error)
                    
                    self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: error.localizedDescription);
                    JustHUD.shared.hide()
                }
                
                
                
                
                
            case.failure(let error):
                
                JustHUD.shared.hide()
                
                self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: error.localizedDescription);
                
            }
            
        }
    }
    func changeQuote(_ evalue: String?) {
        
        
   
        JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        var emailt = ""
        
        if let emaild = evalue {
            emailt = emaild
        }
        
        
        
        let parameters:[String: Any] = ["emailId":emailt]
        
        Alamofire.request(APPURL.forgotpasswordApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
                 self.dismissDialogViewController(LSAnimationPattern.fadeInOut)
                
                
                do {
                    let homrres:forgotRootClass = try JSONDecoder().decode(forgotRootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        
                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                        
                        
                    }else{
                        
                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                        JustHUD.shared.hide()
                        
                    }
                    
                } catch {
                    print(error)
                    
                    self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: error.localizedDescription);
                    JustHUD.shared.hide()
                }
                
                
                
                
                
            case.failure(let error):
                 self.dismissDialogViewController(LSAnimationPattern.fadeInOut)
                JustHUD.shared.hide()
                
                self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: error.localizedDescription);
                
            }
            
        }
    }
    
    func close() {
       self.dismissDialogViewController(LSAnimationPattern.fadeInOut)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        self.loginmethod();
    }
    
    @IBOutlet weak var unameTxt: UITextField!
    @IBOutlet weak var pwdText: UITextField!
       let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.unameTxt.setBottomBorder(img: "man",placeholder:"Email")
         self.pwdText.setBottomBorder(img: "uname",placeholder:"Password")
        self.unameTxt.text = "alexkevin"
         self.pwdText.text = "123456"
      
        GIDSignIn.sharedInstance().signOut()
        
        
        
        
        
        let manager = FBSDKLoginManager()
        FBSDKAccessToken.setCurrent(nil)
        manager.logOut()
        
 
       
        // Do any additional setup after loading the view, typically from a nib.
    }
     func loginmethod1(){
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
    
    
    self.present(vc, animated: true, completion: nil)
    }
    func loginmethod(){
        JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        var name = ""
        var password = ""
        if let names = self.unameTxt.text {
           name = names
        }
        if let passwords = self.pwdText.text {
            password = passwords
        }
        
        
        let parameters:[String: Any] = ["username":name,"password":password,"deviceId":"1234324","os":"ios"]
        
        Alamofire.request(APPURL.loginApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
                
                
                do {
                    let homrres:loginRootClass = try JSONDecoder().decode(loginRootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        
                        let resData:loginResponseData =  homrres.responseData!
                        var userid = ""
                        if let id = resData.id {
                           userid = id
                        }
                        UserDefaults.standard.set(userid, forKey:"uid")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
                        
                      
                        self.present(vc, animated: true, completion: nil)
                        
                        
                    }else{
                        
                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                        JustHUD.shared.hide()
                        
                    }
                    
                } catch {
                    print(error)
                   self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: error.localizedDescription);
                    JustHUD.shared.hide()
                }
                
                
                
                
                
            case.failure(let error):
                JustHUD.shared.hide()
                
              self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: error.localizedDescription);
                
            }
            
        }
    }
    @IBAction func forgotActionMethod(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "forgot") as! ForgotViewController
        
        vc.delegate = self;
        self.presentDialogViewController(vc, animationPattern: LSAnimationPattern.fadeInOut, backgroundViewType: LSDialogBackgroundViewType.solid, dismissButtonEnabled: true) {
            
        }
    }
    func setPaddingView(strImgname: String,txtField: UITextField){
        let image =  UIImage(named: strImgname)
        
        
        let myButton = UIButton(type: UIButtonType.custom)
        
     
        myButton.frame = CGRect(x: 25, y: 5, width: image!.size.width, height: image!.size.height)
        myButton.setImage(image, for: .normal)

        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        
        paddingView.addSubview(myButton)
        txtField.rightViewMode = .always
        txtField.rightView = paddingView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}

