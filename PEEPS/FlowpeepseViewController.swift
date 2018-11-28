//
//  FlowpeepseViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 10/17/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import Alamofire
class FlowpeepseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var flowpeep:flown2Peep!
    @IBOutlet weak var ftbl: UITableView!
    @IBOutlet weak var stbl: UITableView!
    var firstnameArray:NSMutableArray = []
    var secndnameArray:NSMutableArray = []
    var prevoiusindex:Int!
    var prevoiusindex1:Int!
    var selectedFirstName:String!
    var selectedSecondName:String!
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedFirstName = ""
        selectedSecondName = ""
        self.prevoiusindex = -1;
        self.prevoiusindex1 = -1;
        ftbl.delegate = self
        ftbl.dataSource = self
        
        stbl.delegate = self
        stbl.dataSource = self
        
        
        stbl.layer.borderWidth = 0.5
        stbl.layer.borderColor = UIColor.black.cgColor
        
        ftbl.layer.borderWidth = 0.5
        ftbl.layer.borderColor = UIColor.black.cgColor

        
        ftbl.register(UINib(nibName: "gamecell", bundle: nil), forCellReuseIdentifier: "gamecell")
         stbl.register(UINib(nibName: "gamecell", bundle: nil), forCellReuseIdentifier: "gamecell")
        
        ftbl.separatorStyle = UITableViewCellSeparatorStyle.none
        
        ftbl.allowsSelection = false;
        
        stbl.separatorStyle = UITableViewCellSeparatorStyle.none
        
        stbl.allowsSelection = false;
        
        self.getServerData()

        // Do any additional setup after loading the view.
    }

    @IBAction func checkAction(_ sender: Any) {
        
     
        
        if((self.selectedFirstName == self.flowpeep.firstName) && (self.selectedSecondName == self.flowpeep.lastName)){
            
            self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Congratulations");
            
            
        }else{
                                    self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "wrong answer");
            
        }
        
        
        
        
    }
    @IBOutlet weak var himg: UIImageView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        print(APPURL.peepsearchApi);
        
        
        
        Alamofire.request(APPURL.peepflowsearchApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
                
                
                
                do {
                    let homrres:flown2RootClass = try JSONDecoder().decode(flown2RootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        
                        self.flowpeep = homrres.peep
                        let farr:NSArray = (homrres.options?.firstName! as NSArray?)!
                        let larr :NSArray = (homrres.options?.lastName! as NSArray?)!
                        
                        
                        
                        for item in farr {
                            let obj:NSMutableDictionary = [:];
                            let item: String = (item as? String)!
                            obj["name"] = item
                            obj["ischeck"] = "0";
                            self.firstnameArray.add(obj);
                            
                        }
                        
                        for item in larr {
                            let obj:NSMutableDictionary = [:];
                            let item: String = (item as? String)!
                            obj["name"] = item
                            obj["ischeck"] = "0";
                            self.secndnameArray.add(obj);
                            
                        }
                        
                        //                        for item in self.secndnameArray {
                        //                           let item: String = item as? String
                        //                        }
                        
                        
                        
                        Alamofire.request(self.flowpeep.profilePic!).responseImage { response in
                            
                            if let imagess = response.result.value {
                                
//                                self.actind.isHidden = true
//                                self.actind.stopAnimating()
                                
                                self.himg.image = imagess
                                
                                
                                self.himg.contentMode = UIViewContentMode.scaleAspectFit
                                self.himg.layer.cornerRadius = 40
                                self.himg.clipsToBounds = true
                                
                            }else{
//                                self.actind.isHidden = true
//                                self.actind.stopAnimating()
                                
                            }
                            
                            
                        }
                        
                       self.ftbl.reloadData()
                        self.stbl.reloadData()
                        //
                        //                        self.Fname.text = usermodel.firstName
                        //                        self.Lname.text = usermodel.lastName
                        
                        
                        
                        //                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                        
                        
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
    
   
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(tableView == self.ftbl){
            return firstnameArray.count
        }
        if(tableView == self.stbl){
            return secndnameArray.count
        }
        return 0
        
    }
    @objc func oncheckfirst(_ textField: UITextField)
    {
        
        
        if let cell = textField.superview?.superview as? UITableViewCell? {
            let indexPath = self.ftbl.indexPath(for: cell!)
            
            if(self.prevoiusindex>0-1){
                let obj:NSMutableDictionary = self.firstnameArray [(self.prevoiusindex)!] as! NSMutableDictionary
                obj["ischeck"] = "0"
                self.firstnameArray [(self.prevoiusindex)!] = obj
            }
            
            let obj:NSMutableDictionary = self.firstnameArray [(indexPath?.row)!] as! NSMutableDictionary
            let ischeck:String = obj["ischeck"] as! String
            if(ischeck == "0"){
                self.selectedFirstName = obj["name"] as! String
                self.prevoiusindex = indexPath?.row;
                obj["ischeck"] = "1"
            }else{
                obj["ischeck"] = "0"
            }
            self.firstnameArray [(indexPath?.row)!] = obj
            
            

            


        }


        self.ftbl.reloadData()
        
        
    }
   
    @objc func onchecksecond(_ textField: UITextField)
    {
        
        
        if let cell = textField.superview?.superview as? UITableViewCell? {
            let indexPath = self.stbl.indexPath(for: cell!)
            
            if(self.prevoiusindex1>0-1){
                let obj:NSMutableDictionary = self.secndnameArray [(self.prevoiusindex1)!] as! NSMutableDictionary
                obj["ischeck"] = "0"
                self.secndnameArray [(self.prevoiusindex1)!] = obj
            }
            
            let obj:NSMutableDictionary = self.secndnameArray [(indexPath?.row)!] as! NSMutableDictionary
            let ischeck:String = obj["ischeck"] as! String
            if(ischeck == "0"){
                self.selectedSecondName = obj["name"] as! String
                self.prevoiusindex1 = indexPath?.row;
                obj["ischeck"] = "1"
            }else{
                obj["ischeck"] = "0"
            }
            self.secndnameArray [(indexPath?.row)!] = obj
            
            
            
            
            
            
        }
        
        
        self.stbl.reloadData()
        
        
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        if(tableView == self.ftbl){
            cell = tableView.dequeueReusableCell(withIdentifier: "gamecell")
            let chekfBtn:UIButton=(cell.viewWithTag(780) as? UIButton)!
            chekfBtn.addTarget(self, action: #selector(self.oncheckfirst), for: UIControlEvents.touchUpInside)
            
            //        let fname = self.firstnameArray [indexPath.row]
            
            
            let fname:NSMutableDictionary = self.firstnameArray [indexPath.row] as! NSMutableDictionary
            
            
            let fnames:UILabel=(cell.viewWithTag(781) as? UILabel)!
           
            fnames.text = (fname["name"] as! String)
            
            
            let ischeck:String = fname["ischeck"] as! String
            if(ischeck == "0"){
//                obj["ischeck"] = false
                chekfBtn.setImage(UIImage(named: "uncheck"), for: .normal)
            }else{
           chekfBtn.setImage(UIImage(named: "check"), for: .normal)
            }

            
           
 
            
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "gamecell")
            let chekfBtn:UIButton=(cell.viewWithTag(780) as? UIButton)!
            chekfBtn.addTarget(self, action: #selector(self.onchecksecond), for: UIControlEvents.touchUpInside)
            
            //        let fname = self.firstnameArray [indexPath.row]
            
            
           
            let lname:NSMutableDictionary = self.secndnameArray [indexPath.row] as! NSMutableDictionary
            
           
            let lnames:UILabel=(cell.viewWithTag(781) as? UILabel)!
            
            lnames.text = (lname["name"] as! String)
            
            let ischeck:String = lname["ischeck"] as! String
            if(ischeck == "0"){
                //                obj["ischeck"] = false
                chekfBtn.setImage(UIImage(named: "uncheck"), for: .normal)
            }else{
                chekfBtn.setImage(UIImage(named: "check"), for: .normal)
            }
        }
        
        
        
        
        
        return cell
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        var size:CGFloat!
        
        size = 50.0
        
        
        
        
        
        
        
        return size;
        
        
    }
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(tableView == self.ftbl){
            return "First Name"
        }else{
            return "Last Name"
        }
      
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
