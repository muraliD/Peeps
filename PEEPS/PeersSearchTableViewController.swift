//
//  PeersSearchTableViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 9/10/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import ASHorizontalScrollView
import Alamofire

class PeersSearchTableViewController: UITableViewController,UISearchBarDelegate {
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    weak var delegate: SecondVCDelegate?
     var fdatePicker = UIDatePicker()
    var namefield:String!
    var fromdate:String!
    var todate:String!
    var minc:String!
    var maxc:String!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Peer Peeps Search"
   
        self.searchbar.delegate = self;
       namefield=""
       minc=""
       maxc=""
       fromdate=""
       todate=""
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.SetBackBarButtonCustom()
    }
    @IBOutlet weak var searchbar: UISearchBar!
    func searchMethod(){
        
        JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let defaults = UserDefaults.standard
        let userId = defaults.string(forKey: "uid")
        var parameters: [String: Any]
        parameters = [:]
        
        var uid = ""
        var text = ""
        var minp = ""
        var maxp = ""
        var td = ""
        var fd = ""
        
        if let st = searchbar!.text {
            text = st
        }
        
        if let id =   self.minc {
            minp = id
        }
        if let id =   self.fromdate {
            fd = id
        }
        if let id =   self.todate {
            td = id
        }
        if let id =    self.maxc {
            maxp = id
        }
        
        
        
        if let id = userId {
            uid = id
        }
       
        
        
        parameters = ["name":text ,"minPeepsCount": minp,"maxPeepsCount": maxp,"fromDate": fd,"toDate": td]
        
        
        
        Alamofire.request(APPURL.peerpeepssearchApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
                
                
                
                do {
                    let homrres:peergrpRootClass = try JSONDecoder().decode(peergrpRootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        
                        
                        let array:NSArray = homrres.responseData! as NSArray
                        self.dismiss(animated: true, completion: nil)
                        self.delegate?.getpeeps!(array, type: "S")
                        //                        self.countLbl.text = String(self.ResultsArray.count)+" "+"Peeps"
                        //                        self.collectionView.reloadData()
                        //                        let usermodel:peepsModelResponseData = userdata[0] as! peepsModelResponseData
                        //
                        //                        self.Fname.text = usermodel.firstName
                        //                        self.Lname.text = usermodel.lastName
                        
                        
                        
                        //                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                        
                        
                    }else{
                        
                        //                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                        JustHUD.shared.hide()
                        
                    }
                    
                }  catch {
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
  
        self.searchMethod();
    }
    func SetBackBarButtonCustom()
    {
        //Back buttion
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "la-29"), for: UIControlState())
        btnLeftMenu.addTarget(self, action: #selector(self.onClcikBack), for: UIControlEvents.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        
         self.tableView.register(UINib(nibName: "peeAdd1", bundle: nil), forCellReuseIdentifier: "peeAdd1")
        self.tableView.register(UINib(nibName: "LAdded", bundle: nil), forCellReuseIdentifier: "LAdded")
        self.tableView.register(UINib(nibName: "DAdded", bundle: nil), forCellReuseIdentifier: "DAdded")
        self.tableView.register(UINib(nibName: "PAdded", bundle: nil), forCellReuseIdentifier: "PAdded")
        self.tableView.register(UINib(nibName: "searcc", bundle: nil), forCellReuseIdentifier: "searcc")
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.tableView.allowsSelection = false;
    }
    
    @objc func onClcikBack()
    {
        self.delegate?.getpeeps!([], type: "")
        self.dismiss(animated: true, completion: nil);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func buttonClicked(sender:UIButton) {
        if(sender.titleColor(for: .normal) == UIColor.purple){
            sender.setTitleColor(UIColor.white, for: .normal);
            sender.backgroundColor = UIColor.purple
        }else{
            sender.setTitleColor(UIColor.purple, for: .normal);
            sender.backgroundColor = UIColor.white
        }
        
        
        
        
    }
    func setPaddingView(strImgname: String,txtField: UITextField,place:String){
        let image =  UIImage(named: strImgname)
        
        
        let myButton = UIButton(type: UIButtonType.custom)
        txtField.layer.borderWidth = 0.5
        txtField.layer.borderColor = UIColor.lightGray.cgColor
        
        //Set a frame for the button. Ignored in AutoLayout/ Stack Views
        myButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        myButton.setImage(image, for: .normal)
        myButton.layer.borderWidth = 0.5
        myButton.layer.borderColor = UIColor.purple.cgColor
        myButton.layer.cornerRadius = 5.0
        //        myButton.addTarget(self, action:#selector(handlepop(_:)), for: .touchUpInside)
        //Set a frame for the button. Ignored in AutoLayout/ Stack Views
        
        
        
        
        
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        paddingView.backgroundColor = UIColor.purple
        paddingView.layer.borderWidth = 0.5
        paddingView.layer.cornerRadius = 5.0
        paddingView.layer.borderColor = UIColor.purple.cgColor
        paddingView.addSubview(myButton)
        txtField.rightViewMode = .always
        txtField.rightView = paddingView
        
        
        
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        txtField.leftViewMode = .always
        txtField.leftView = leftView
        
        txtField.layer.cornerRadius = 5.0
        txtField.placeholder = place
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        
        if(indexPath.row==0 ){
            cell = tableView.dequeueReusableCell(withIdentifier: "peeAdd1")
            let txt1:UITextField=(cell.viewWithTag(777) as? UITextField)!
//            txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
          txt1.text = self.namefield
//            txt1.delegate = self
             txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            self.setPaddingView(strImgname: "sear", txtField: txt1, place: "Name of Peer Peep");
            
        }
        if(indexPath.row==1){
            cell = tableView.dequeueReusableCell(withIdentifier: "peeAdd1")
            let txt1:UITextField=(cell.viewWithTag(777) as? UITextField)!
            txt1.text = self.minc
            txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            self.setPaddingView(strImgname: "sear", txtField: txt1, place: "Max Number of Peeps");
           
        }
        if(indexPath.row==2){
            cell = tableView.dequeueReusableCell(withIdentifier: "peeAdd1")
            let txt1:UITextField=(cell.viewWithTag(777) as? UITextField)!
             txt1.text = self.maxc
             txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            self.setPaddingView(strImgname: "sear", txtField: txt1, place: "Min Number of Peeps");
            
        }
        if(indexPath.row==3){
           
            
            
            
            cell = tableView.dequeueReusableCell(withIdentifier: "DAdded")
            let txtfrmdate:UITextField=(cell.viewWithTag(888) as? UITextField)!
            txtfrmdate.text = self.fromdate
            let txttodate:UITextField=(cell.viewWithTag(889) as? UITextField)!
            txttodate.text = self.todate
            self.setPaddingView(strImgname: "dat", txtField: txtfrmdate)
            self.handlesel(txtfrmdate)
            self.setPaddingView(strImgname: "dat", txtField: txttodate)
            self.handlesel(txttodate)
            
            
            
            
            
            
            
            
        }
        if(indexPath.row==4){
            cell = tableView.dequeueReusableCell(withIdentifier: "searcc")
            
            let searcBtn:UIButton=(cell.viewWithTag(567) as? UIButton)!
            let cancelbtn:UIButton=(cell.viewWithTag(568) as? UIButton)!
            let clearbtn:UIButton=(cell.viewWithTag(569) as? UIButton)!
            
            searcBtn.addTarget(self, action: #selector(self.searchclickc), for: UIControlEvents.touchUpInside)
            cancelbtn.addTarget(self, action: #selector(self.cancelclickc), for: UIControlEvents.touchUpInside)
            clearbtn.addTarget(self, action: #selector(self.clearclickc), for: UIControlEvents.touchUpInside)
            
        }
        
        //        cell?.contentView.layer.cornerRadius = 2.0
        //        cell?.contentView.layer.borderWidth = 1.0
        //        cell?.contentView.layer.borderColor = UIColor.clear.cgColor
        //        cell?.contentView.layer.masksToBounds = true;
        //
        //        cell?.layer.shadowColor = UIColor.white.cgColor
        //        cell?.layer.shadowOffset = CGSize(width:0,height: 2.0)
        //        cell?.layer.shadowRadius = 2.0
        //        cell?.layer.shadowOpacity = 1.0
        //        cell?.layer.masksToBounds = false;
        //        cell?.layer.shadowPath = UIBezierPath(roundedRect:(cell?.bounds)!, cornerRadius:(cell?.contentView.layer.cornerRadius)!).cgPath
        
        return cell
    }
    @objc  func searchclickc(sender: UIButton) {
        
        self.searchMethod()
    }
    @objc  func cancelclickc(sender: UIButton) {
        self.delegate?.getpeeps!([], type: "")
        self.dismiss(animated: true, completion: nil);
        
    }
    @objc  func clearclickc(sender: UIButton) {
        
        self.delegate?.getpeeps!([], type: "")
        self.dismiss(animated: true, completion: nil);
    }
    func handlesel(_ txtView: UITextField){
        
        print(txtView.tag);
        
        
        fdatePicker.datePickerMode = .date
        fdatePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        //        self.myPickerView.delegate = self
        
        
        
        
        //        self.myPickerView.dataSource = self
        fdatePicker.backgroundColor = UIColor.white
        txtView.inputView = self.fdatePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0.30, green: 0.30, blue: 0.55, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        
        let doneButton:UIBarButtonItem!
        if(txtView.tag == 888){
            doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(PeepSearchTablvController.doneClick))
        }else{
            doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(PeepSearchTablvController.doneClick1))
        }
        
        //
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        spaceButton.tag = 5
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(PeepSearchTablvController.cancelClick))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtView.inputAccessoryView = toolBar
        
        //           self.myPickerView.selectRow(0, inComponent: 0, animated: true);
        //
        //          self.myPickerView.delegate?.pickerView?(self.myPickerView, didSelectRow: 0, inComponent: 0)
        
        
        
    }
    @objc func doneClick() {
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: fdatePicker.date ) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        print(myStringafd)
        
        self.fromdate = myStringafd
        
        //        self.reloadtype = 1
        //        self.cartTable.reloadData()
        self.view.endEditing(true)
        self.tableView.reloadData();
        
        
    }
    @objc func doneClick1() {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: fdatePicker.date ) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        print(myStringafd)
        self.todate = myStringafd
        self.view.endEditing(true)
        self.tableView.reloadData();
    }
    @objc func cancelClick() {
        self.view.endEditing(true)
    }
    func setPaddingView(strImgname: String,txtField: UITextField){
        let image =  UIImage(named: strImgname)
        
        
        let myButton = UIButton(type: UIButtonType.custom)
        txtField.layer.borderWidth = 0.5
        txtField.layer.borderColor = UIColor.lightGray.cgColor
        
        //Set a frame for the button. Ignored in AutoLayout/ Stack Views
        myButton.frame = CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height)
        myButton.setImage(image, for: .normal)
        myButton.layer.borderWidth = 0.5
        myButton.layer.borderColor = UIColor.purple.cgColor
        myButton.layer.cornerRadius = 5.0
        //        myButton.addTarget(self, action:#selector(handlepop(_:)), for: .touchUpInside)
        //Set a frame for the button. Ignored in AutoLayout/ Stack Views
        
        
        
        
        
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        paddingView.backgroundColor = UIColor.purple
        paddingView.layer.borderWidth = 0.5
        paddingView.layer.cornerRadius = 5.0
        paddingView.layer.borderColor = UIColor.purple.cgColor
        paddingView.addSubview(myButton)
        txtField.rightViewMode = .always
        txtField.rightView = paddingView
        
        
        
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        txtField.leftViewMode = .always
        txtField.leftView = leftView
        
        txtField.layer.cornerRadius = 5.0
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        var size:CGFloat!
        if(indexPath.row==0){
            size = 90.0
        }
        if(indexPath.row==1){
            size = 90.0
        }
        if(indexPath.row==2){
            size = 90.0
        }
        if(indexPath.row==3){
            size = 128.0
        }
        if(indexPath.row==4){
            size = 128.0
        }
        
        
        
        
        
        return size;
        
        
    }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        
        if let cell = textField.superview?.superview as? UITableViewCell? {
            let indexPath = self.tableView.indexPath(for: cell!)
            
            if(indexPath?.row==0){
                self.namefield=textField.text!
            }
            
            if(indexPath?.row==1){
                self.minc=textField.text!
            }
            
            if(indexPath?.row==2){
                self.maxc=textField.text!
            }
            
            
            
            
            
            
        }
        
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
