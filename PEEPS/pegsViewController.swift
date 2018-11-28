//
//  pegsViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 10/27/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import Alamofire

class pegsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var searctxt: UISearchBar!
      let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var tblview: UITableView!
     weak var delegate: SecondVCDelegate?
    var pegsArray:NSMutableArray = []
    var selectedkey:NSMutableDictionary = [:]
    var finalArray:NSMutableArray = []
    var isfname:Bool!
    var sdata:String!
     var type:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Flow20"
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "la-29"), for: UIControlState())
        btnLeftMenu.addTarget(self, action: #selector(self.onClcikBack), for: UIControlEvents.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        
        
        let btnLeftMenu1: UIButton = UIButton()
        btnLeftMenu1.setImage(UIImage(named: "la-29"), for: UIControlState())
        //        btnLeftMenu.addTarget(self, action: #selector(self.onClcikBack), for: UIControlEvents.touchUpInside)
        btnLeftMenu1.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton1 = UIBarButtonItem(customView: btnLeftMenu1)
        self.navigationItem.rightBarButtonItem = barButton1
          tblview.dataSource = self;
        tblview.delegate = self;
      
      tblview.register(UINib(nibName: "peglist", bundle: nil), forCellReuseIdentifier: "peglist")
        
        tblview.register(UINib(nibName: "selectedPeg", bundle: nil), forCellReuseIdentifier: "selectedPeg")
        
      tblview.separatorStyle = UITableViewCellSeparatorStyle.none
self.getServerData()
        // Do any additional setup after loading the view.
    }
    @IBAction func checkAction(_ sender: Any) {
        
        
        if(self.finalArray.count>0){
            if(isfname == true){
                self.delegate?.getpeeps!(self.finalArray, type: "F")
            }else{
                self.delegate?.getpeeps!(self.finalArray, type: "L")
            }
             self.dismiss(animated: true, completion: nil)
        }else{
                                     self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Please select atleast one peg");
            
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
        var names = ""
         if let name = sdata {
            names = name
        }
        if let id = userId {
           
            
            if(isfname == true){
                 parameters = ["userId":id,"firstname":names]
            }else{
                 parameters = ["userId":id,"lastname":names]
            }
        }
        
        
        
        
        
        Alamofire.request(APPURL.generatepegsRouteApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
                
                
                
                do {
                    let homrres:pegsRootClass = try JSONDecoder().decode(pegsRootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        
                        let data:pegsResponseData = (homrres.responseData)!
                        
                        var array:NSArray = [];
                        if(self.isfname == true){
                            
                           array = data.firstName!  as NSArray
                            
                        }else{
                            array = data.lastName!  as NSArray
                        }
                        self.pegsArray = NSMutableArray(array: array)
                        self.tblview.reloadData();
                        
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
    @objc func onClcikBack()
    {
        self.dismiss(animated: true, completion: nil);
        
        //        self.delegate?.close!()
    }

    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0){
              return self.pegsArray.count
        }else{
            return self.finalArray.count;
        }
      
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        if(indexPath.section == 0){
        cell = tableView.dequeueReusableCell(withIdentifier: "peglist")
        
        let lbl:UILabel=(cell.viewWithTag(45) as? UILabel)!
        let lbl1:UILabel=(cell.viewWithTag(46) as? UILabel)!
        
          if(isfname == true){
        let data:pegsFirstName =  self.pegsArray [indexPath.row] as! pegsFirstName
        lbl.text = data.peg
        lbl1.text = data.node
          }else{
            let data:pegsLastName =  self.pegsArray [indexPath.row] as! pegsLastName
            lbl.text = data.peg
            lbl1.text = data.node
            }
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "selectedPeg")
            let lbl1:UITextView=(cell.viewWithTag(310) as? UITextView)!
            lbl1.text = self.finalArray[indexPath.row] as! String
            
        }
        
//        let imageView:UIImageView=(cell.viewWithTag(455) as? UIImageView)!
//
//
//
//
//        if(indexPath.row == 0){
//            lbl.text = "Peep Flow - Node"
//
//
//            imageView.image = UIImage(named: "f1")
//        }
//        if(indexPath.row == 1){
//            lbl.text = "Peep Flow - Search"
//            imageView.image = UIImage(named: "f2")
//        }
//        if(indexPath.row == 2){
//            lbl.text = "Peep Go - Pop Up"
//            imageView.image = UIImage(named: "f3")
//        }
        
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if(isfname == true){
             let data:pegsFirstName =  self.pegsArray [indexPath.row] as! pegsFirstName
            self.selectedkey.setValue(data.peg, forKey: data.peg!);
         }else{
             let data:pegsLastName =  self.pegsArray [indexPath.row] as! pegsLastName
            self.selectedkey.setValue(data.peg, forKey: data.peg!);
        }
        
        
        self.pegsArray.removeObject(at: indexPath.row)
        
        self.finalArray = [];
         var finalstring:String = ""
     
        
        
        
        
        
        
        
        

        
        let doneArray = self.selectedkey.allKeys
        
        for item in doneArray {
         
            
            finalstring += item as! String + "-"
            
        }
        
        
        let endIndex = finalstring.index(finalstring.endIndex, offsetBy: -1)
        
        self.finalArray.add(finalstring.substring(to: endIndex))
        
        
        
        self.tblview.reloadData()
        
        
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let data:pegsFirstName =  self.pegsArray [indexPath.row] as! pegsFirstName
//        self.selectedkey.removeObject(forKey: data.peg);
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        var size:CGFloat!
        if(indexPath.section == 0){
        size = 44.0
        }else{
              size = 50.0
        }
        
        
        
        
        
        
        return size;
        
        
    }
    func findKeyForValue(value: String, dictionary: [String: [String]]) ->String?
    {
        for (key, array) in dictionary
        {
            if (array.contains(value))
            {
                return key
            }
        }
        
        return nil
    }
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         if(section == 0){
            if(self.pegsArray.count>0){
                return "Please Select Pegs"
            }
         }
         else{
            return "Selected Pegs Are"
        }
        
        return ""
    }
    
}
