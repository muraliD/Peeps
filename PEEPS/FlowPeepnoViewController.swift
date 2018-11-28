//
//  FlowPeepnoViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 10/18/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import Alamofire

class FlowPeepnoViewController: UIViewController {

    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var himge: UIImageView!
    var flowpeep: flown1Peep!
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getServerData();

        // Do any additional setup after loading the view.
    }

    @IBAction func checkAction(_ sender: Any) {
        var fnames = ""
        var lnames = ""
        if let names = self.fname.text {
            fnames = names
        }
        if let fnames = self.lname.text {
            lnames = fnames
        }
        
        
        if(fnames.count>0 && lnames.count>0){
            
            if(fnames ==  self.flowpeep.firstName && lnames == self.flowpeep.lastName){
                self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Correct Answer");
            }else{
                self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Wrong Answer");
            }
            
        }else{
            
             self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Enter Valid data");
        }
        
        
    }
    
    func getServerData(){
        
        
        
        
        
        JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let defaults = UserDefaults.standard
        let userId = defaults.string(forKey: "uid")
        var parameters: [String: Any]
        parameters = [:]
        
        
        if let id = userId {
            parameters = ["userId":id]
        }
        
        print(APPURL.Routepeepflownode);
        
        
        
        Alamofire.request(APPURL.peepflownodeApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
                
                
                
                do {
                    let homrres:flown1RootClass = try JSONDecoder().decode(flown1RootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        
                        self.flowpeep = homrres.peep
                        
                        Alamofire.request(self.flowpeep.profilePic!).responseImage { response in
                            
                            if let imagess = response.result.value {
                                
                                //                                self.actind.isHidden = true
                                //                                self.actind.stopAnimating()
                                
                                self.himge.image = imagess
                                
                                
                                self.himge.contentMode = UIViewContentMode.scaleAspectFit
                                self.himge.layer.cornerRadius = 40
                                self.himge.clipsToBounds = true
                                
                            }else{
                                //                                self.actind.isHidden = true
                                //                                self.actind.stopAnimating()
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                        
                    }else{
                        
                        //                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
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
