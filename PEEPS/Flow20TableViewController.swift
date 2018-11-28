//
//  Flow20TableViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 10/14/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit

class Flow20TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Flow20"
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "la-29"), for: UIControlState())
        btnLeftMenu.addTarget(self, action: #selector(self.onClcikBack), for: UIControlEvents.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        self.tableView.register(UINib(nibName: "flow", bundle: nil), forCellReuseIdentifier: "flow")
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        

            cell = tableView.dequeueReusableCell(withIdentifier: "flow")
        
      
         let imageView:UIImageView=(cell.viewWithTag(333) as? UIImageView)!
   
        
        
        
        if(indexPath.row == 0){
        
            
          
            imageView.image = UIImage(named: "FLOW - NODE")
        }
        if(indexPath.row == 1){
           
             imageView.image = UIImage(named: "FLOW - NAME")
        }
        if(indexPath.row == 2){
          
             imageView.image = UIImage(named: "FLOW - GRID")
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0){
            let vc = storyboard?.instantiateViewController(withIdentifier: "fpno") as! FlowPeepnoViewController
            
            
            self.navigationController?.pushViewController(vc,animated: true)
            
          
  
        }
        if(indexPath.row == 1){
            let vc = storyboard?.instantiateViewController(withIdentifier: "pst") as! FlowpeepseViewController
            
            
            self.navigationController?.pushViewController(vc,animated: true)
            
        }
        if(indexPath.row == 2){
            let vc = storyboard?.instantiateViewController(withIdentifier: "fggo") as! FloePeepGoViewController
            
            
            self.navigationController?.pushViewController(vc,animated: true)
            
        }
        
        
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        var size:CGFloat!
       
            size = 184.0
     
        
        
        
        
        
        
        return size;
        
        
    }

}
