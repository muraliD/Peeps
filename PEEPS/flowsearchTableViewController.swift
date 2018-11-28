//
//  flowsearchTableViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 10/14/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import Alamofire

class flowsearchTableViewController: UITableViewController {
    var flowpeep:flown2Peep!
    var firstnameArray:NSMutableArray = []
    var secndnameArray:NSMutableArray = []
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
  self.title = "Flow Search"
        
        self.tableView.register(UINib(nibName: "gamecell", bundle: nil), forCellReuseIdentifier: "gamecell")
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.tableView.allowsSelection = false;
        self.getServerData();
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
                        obj["ischeck"] = false;
                        self.firstnameArray.add(obj);
                        
                        }
                        
                        for item in larr {
                            let obj:NSMutableDictionary = [:];
                            let item: String = (item as? String)!
                            obj["name"] = item
                            obj["ischeck"] = false;
                            self.secndnameArray.add(obj);
                            
                        }
                        
//                        for item in self.secndnameArray {
//                           let item: String = item as? String
//                        }
                        
                        
                        self.tableView.reloadData()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return firstnameArray.count
    }
    @objc func oncheckfirst(_ textField: UITextField)
    {
        
        
        if let cell = textField.superview?.superview as? UITableViewCell? {
            let indexPath = self.tableView.indexPath(for: cell!)
            let obj:NSMutableDictionary = self.firstnameArray [(indexPath?.row)!] as! NSMutableDictionary
            let ischeck:Bool = obj["ischeck"] as! Bool
            if(ischeck == true){
                obj["ischeck"] = false
            }else{
                 obj["ischeck"] = true
            }
            
            self.firstnameArray [(indexPath?.row)!] = obj


        }
        
        
          self.tableView.reloadData()
            
    
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        

            cell = tableView.dequeueReusableCell(withIdentifier: "gamecell")
               let chekfBtn:UIButton=(cell.viewWithTag(780) as? UIButton)!
         chekfBtn.addTarget(self, action: #selector(self.oncheckfirst), for: UIControlEvents.touchUpInside)
        
//        let fname = self.firstnameArray [indexPath.row]
       
        
        let fname:NSMutableDictionary = self.firstnameArray [indexPath.row] as! NSMutableDictionary
        let lname:NSMutableDictionary = self.secndnameArray [indexPath.row] as! NSMutableDictionary
        
         let fnames:UILabel=(cell.viewWithTag(781) as? UILabel)!
         let lnames:UILabel=(cell.viewWithTag(783) as? UILabel)!
        fnames.text = (fname["name"] as! String)
        lnames.text = (lname["name"] as! String)
        
      
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        var size:CGFloat!
      
            size = 50.0
     
        return size;
        
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
