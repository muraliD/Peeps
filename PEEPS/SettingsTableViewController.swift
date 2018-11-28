//
//  SettingsTableViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 8/30/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import FacebookLogin

import GoogleSignIn
class SettingsTableViewController: UITableViewController {
 let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.SetBackBarButtonCustom()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func SetBackBarButtonCustom()
    {
           self.title = "Settings"
    
                let btnLeftMenu: UIButton = UIButton()
                btnLeftMenu.setImage(UIImage(named: "la-29"), for: UIControlState())
                btnLeftMenu.addTarget(self, action: #selector(self.onClcikBack), for: UIControlEvents.touchUpInside)
                btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
                let barButton = UIBarButtonItem(customView: btnLeftMenu)
                self.navigationItem.leftBarButtonItem = barButton
        
        
      
        
        self.tableView.register(UINib(nibName: "settCell", bundle: nil), forCellReuseIdentifier: "settCell")
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
       
    }
    
    @objc func onClcikBack()
    {
        self.dismiss(animated: true, completion: nil);
        
//        self.delegate?.close!()
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
        return 1
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        if(indexPath.row==0 ){
            cell = tableView.dequeueReusableCell(withIdentifier: "settCell")
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        var size:CGFloat!
        if(indexPath.row==0){
            size = 58.0
        }
        
        
        
        
        
        
        return size;
        
        
    }
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    GIDSignIn.sharedInstance().signOut()
        
        appDelegate?.fblogout()// this is an instance function
   
      self.appDelegate?.switchBack()
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
