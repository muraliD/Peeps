//
//  signup.swift
//  PEEPS
//
//  Created by Murali Dadi on 7/28/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import Alamofire

class signup: UIViewController {
   let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var scrl: UIScrollView!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var cpwd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fname.setBottomBorder(img: "man",placeholder:"First Name")
        lname.setBottomBorder(img: "man",placeholder:"Last Name")
        
        name.setBottomBorder(img: "man",placeholder:"User Name")
        email.setBottomBorder(img: "email",placeholder:"Email")
        pwd.setBottomBorder(img: "uname",placeholder:"Password")
        cpwd.setBottomBorder(img: "uname",placeholder:"Conform Password")
        
//       self.scrl.contentOffset = CGPoint(x: 0, y:30)
//        self.scrl.backgroundColor = UIColor.green


        // Do any additional setup after loading the view.
    }
    @IBAction func signupmethod(_ sender: Any) {
        
        
        JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        var named = ""
        var lnamed = ""
        var fnamed = ""
        var emaild = ""
        var pwdd = ""
        var cpwdd = ""
        if let names = self.name.text {
            named = names
        }
        if let fnames = self.fname.text {
            fnamed = fnames
        }
        if let lnames = self.lname.text {
            lnamed = lnames
        }
        
        if let emails = self.email.text {
            emaild = emails
        }
        
        if let pwds = self.pwd.text {
            pwdd = pwds
        }
        
        if let cpwds = self.cpwd.text {
            cpwdd = cpwds
        }
        
        
        
        
        let parameters:[String: Any] = ["firstname":fnamed,"lastname":lnamed,"username":named,"email":emaild,"password":pwdd,"confirmPassword":cpwdd,"deviceId":"1234324","os":"ios"]
        
        Alamofire.request(APPURL.registerApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
                
                
                do {
                    let homrres:signupRootClass = try JSONDecoder().decode(signupRootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                        JustHUD.shared.hide()
//                        let resData:signupResponseData =  homrres.responseData!
//                        UserDefaults.standard.set("uid", forKey: resData.id!)
//                        self.dismiss(animated: true, completion: nil);
                        
                        
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
    
    @IBAction func backMethod(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
