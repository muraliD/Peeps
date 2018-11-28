//
//  AddPeepTableViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 8/27/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import Alamofire
import ContactsUI
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
class AddPeepTableViewController: UITableViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CNContactPickerDelegate,SecondVCDelegate  {
     let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
 @IBOutlet weak var topImgView: UIImageView!
     var peepModel:addpeepModel!
     weak var delegate: SecondVCDelegate?
    var imagePicker = UIImagePickerController()
    var upimg:UIImage!
     var fpeg:String!
     var lpeg:String!
       var selectedcell:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
       self.selectedcell = -1
        self.SetBackBarButtonCustom();
        imagePicker.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        
        self.fpeg = "";
        self.lpeg = "";
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
 topImgView.isUserInteractionEnabled = true
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        var xf = 0;
       
        
          self.peepModel = addpeepModel(data: ["fName":"","lName":"","email":"","groupid":"","image":""] as [String : AnyObject])!
        
        
        let inputArray = [["name":"MyPeeps","img":"la"],["name":"fb1","img":"fb1"],["name":"go1","img":"go1"],["name":"Flow20","img":"cont1"]];
        
        
        var index = -1;
        
        for item in inputArray {
            let myButton = UIButton(type: UIButtonType.custom)
            //Set a frame for the button. Ignored in AutoLayout/ Stack Views
            
            myButton.backgroundColor = UIColor.clear
            
            
            myButton.frame = CGRect(x:  CGFloat(xf), y: 0, width: self.view.frame.size.width/4, height: topImgView.frame.size.height);
            myButton.tag = index
            myButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
            
            
            xf = xf + Int(self.view.frame.size.width/4)
            
            myButton.setImage(UIImage(named:item["img"]!), for: .normal)
            
            
            index =  index+1
            myButton.tag = index
            
            
            //Set background color
            //            myButton.layer.borderColor = UIColor.white.cgColor
            //
            //
            //            myButton.layer.borderWidth = 2.0
            
            
            
            topImgView.addSubview(myButton)
            
        }
        
        
    }
    func getpeeps(_ evalue: NSArray?, type: String?) {
        if(type == "F"){
            
           
            self.fpeg = (evalue![0] as! String)
            
//            self.types = "S"
//            self.ResultsArray = evalue! as NSArray
//            self.countLbl.text = String(self.ResultsArray.count)+" "+"Peeps"
//            self.collectionView.reloadData()
        }
        if(type == "L"){
                 self.lpeg = (evalue![0] as! String)
           
            
            
            //            self.types = "S"
            //            self.ResultsArray = evalue! as NSArray
            //            self.countLbl.text = String(self.ResultsArray.count)+" "+"Peeps"
            //            self.collectionView.reloadData()
        }
         self.tableView.reloadData();
        
    }
    @objc func buttonClicked(sender:UIButton) {
        if(sender.tag == 0){
            
            self.dismiss(animated: true, completion: nil)
             self.delegate?.close!()
        }
        if(sender.tag == 1){
            let params = ["fields": "id,name"]
            
            let graphRequest = FBSDKGraphRequest(graphPath: "/1984027891653248/friends", parameters: params)
            let connection = FBSDKGraphRequestConnection()
            connection.add(graphRequest, completionHandler: { (connection, result, error) in
                if error == nil {
                    
                    var resultdict = result as! NSDictionary
                    print("Result Dict: \(resultdict)")
                    var friends : NSArray = resultdict.object(forKey: "data") as! NSArray
                    print("Found \(friends.count) friends")
                } else {
                    print("Error Getting Friends \(error)");
                }
                
            })
            
            connection.start()
        }
        if(sender.tag == 3){
            let cnPicker = CNContactPickerViewController()
            cnPicker.delegate = self
            self.present(cnPicker, animated: true, completion: nil)
        }
    }
    //MARK:- CNContactPickerDelegate Method
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
//        contacts.forEach { contact in
//            for number in contact.phoneNumbers {
//                let phoneNumber = number.value
//                print("number is = \(phoneNumber)")
//            }
//        }
//    }
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
                print(contact.givenName)
        print(contact.familyName)
//        print(contact.emailAddresses.first)
        var email = "";
        if let emailValue : CNLabeledValue = contact.emailAddresses.first
        {
            print(emailValue.value as String)
            email = emailValue.value as String
        }
        if contact.imageDataAvailable {
            // there is an image for this contact
            let image = UIImage(data: contact.imageData!)
               self.upimg = image;
            // Do what ever you want with the contact image below

        }else{
            self.upimg = nil
        }
        
        
        self.peepModel = addpeepModel(data: ["fName":contact.givenName,"lName":contact.familyName,"email":email,"groupid":"","image":""] as [String : AnyObject])!
     
        
        self.tableView.reloadData();
        
        
        print("WYASDFY")
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
    

    func SetBackBarButtonCustom()
    {
        //Back buttion
        //        let btnLeftMenu: UIButton = UIButton()
        //        btnLeftMenu.setImage(UIImage(named: "la-29"), for: UIControlState())
        //        btnLeftMenu.addTarget(self, action: #selector(self.onClcikBack), for: UIControlEvents.touchUpInside)
        //        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        //        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        //        self.navigationItem.leftBarButtonItem = barButton
        
        
        self.tableView.register(UINib(nibName: "peeAdd1", bundle: nil), forCellReuseIdentifier: "peeAdd1")
         self.tableView.register(UINib(nibName: "peeAdd2", bundle: nil), forCellReuseIdentifier: "peeAdd2")
        self.tableView.register(UINib(nibName: "DAdded", bundle: nil), forCellReuseIdentifier: "DAdded")
        self.tableView.register(UINib(nibName: "PAdded", bundle: nil), forCellReuseIdentifier: "PAdded")
        self.tableView.register(UINib(nibName: "searcc", bundle: nil), forCellReuseIdentifier: "searcc")
          self.tableView.register(UINib(nibName: "imagecell", bundle: nil), forCellReuseIdentifier: "imagecell")
        
         self.tableView.register(UINib(nibName: "adpeepbtn", bundle: nil), forCellReuseIdentifier: "adpeepbtn")
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.tableView.allowsSelection = false;
    }
    
    @objc func onClcikBack()
    {
        self.delegate?.close!()
        _ = self.navigationController?.popViewController(animated: true)
      
        
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
        return 6
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        
        if(indexPath.row==0 ){
           
            cell = tableView.dequeueReusableCell(withIdentifier: "peeAdd2")
            let txt1:UITextField=(cell.viewWithTag(777) as? UITextField)!
            let pegl:UILabel=(cell.viewWithTag(333) as? UILabel)!
            pegl.text = self.fpeg
            txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            txt1.text = self.peepModel.fname
             txt1.delegate = self
            self.setPaddingView(strImgname: "pic1", txtField: txt1, place: "First Name");
            
        }
        
        if(indexPath.row==1){
            cell = tableView.dequeueReusableCell(withIdentifier: "peeAdd2")
            let txt1:UITextField=(cell.viewWithTag(777) as? UITextField)!
            let pegl:UILabel=(cell.viewWithTag(333) as? UILabel)!
             pegl.text = self.lpeg
            txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
             txt1.delegate = self
             txt1.text = self.peepModel.lName
            self.setPaddingView(strImgname: "pic1", txtField: txt1, place: "Last Name");
           
        }
        if(indexPath.row==2){
            
            cell = tableView.dequeueReusableCell(withIdentifier: "peeAdd1")
            let txt1:UITextField=(cell.viewWithTag(777) as? UITextField)!
            let leftView = UIView()
            leftView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
            txt1.leftViewMode = .always
            txt1.leftView = leftView
            txt1.delegate = self
            txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            txt1.layer.cornerRadius = 5.0
            txt1.placeholder = "E-mail (Optional)"
              txt1.text = self.peepModel.email
          
        }
        if(indexPath.row==3){
            cell = tableView.dequeueReusableCell(withIdentifier: "peeAdd1")
            let txt1:UITextField=(cell.viewWithTag(777) as? UITextField)!
            let leftView = UIView()
            leftView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
            txt1.leftViewMode = .always
            txt1.leftView = leftView
             txt1.delegate = self
             txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            txt1.layer.cornerRadius = 5.0
            txt1.placeholder = "Peer Group (Optional)"
            txt1.text = self.peepModel.groupid
            
            
            
            
        }
        if(indexPath.row==4){
            cell = tableView.dequeueReusableCell(withIdentifier: "imagecell")
            
            let imgevv:UIImageView=(cell.viewWithTag(666) as? UIImageView)!
            imgevv.layer.cornerRadius = 5.0
            let upbtn:UIButton=(cell.viewWithTag(667) as? UIButton)!
            upbtn.addTarget(self, action:#selector(self.buttonClickedimg), for: .touchUpInside)
            upbtn.layer.cornerRadius = 22.0
            
            if let img = upimg {
                imgevv.image = img;
            }else{
                 imgevv.image = nil;
            }
        }
        if(indexPath.row==5){
            cell = tableView.dequeueReusableCell(withIdentifier: "adpeepbtn")
            
               let upbtn:UIButton=(cell.viewWithTag(555) as? UIButton)!
            upbtn.addTarget(self, action:#selector(self.myImageUploadRequest), for: .touchUpInside)
            
            let canbtn:UIButton=(cell.viewWithTag(556) as? UIButton)!
            canbtn.addTarget(self, action:#selector(self.caneUploadRequest), for: .touchUpInside)
            
            
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
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        
        if let cell = textField.superview?.superview as? UITableViewCell? {
            let indexPath = self.tableView.indexPath(for: cell!)
            
            if(indexPath?.row==0){
                self.peepModel.fname=textField.text!
            }
            if(indexPath?.row==1){
               self.peepModel.lName=textField.text!
            }
            if(indexPath?.row==2){
               self.peepModel.email=textField.text!
            }
            if(indexPath?.row==3){
               self.peepModel.groupid=textField.text!
                
            }
           
            
          
            
            
            
        }
        
    }
     @objc func buttonClickedimg(sender:UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction(title: "Google Images", style: .default, handler: { _ in
            
            if(self.peepModel.fname.count>0 || self.peepModel.fname.count>0){
                self.appDelegate?.opengoogleimages(name: self.peepModel.fname+self.peepModel.lName)
            }else{
               self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Enter First Name or Last Name");
            }
            
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
    
     self.present(alert, animated: true, completion: nil)
    
    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image_data = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageData:Data = UIImagePNGRepresentation(image_data!)!
        
        let imageStr = imageData.base64EncodedString()
        self.peepModel.image = imageStr;
        
       upimg = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.tableView.reloadData()
        

        
        self.dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    @objc func handlepop(butt:UIButton) {
  
        let vc = storyboard?.instantiateViewController(withIdentifier: "peg") as! pegsViewController
        vc.delegate = self
        
        if(butt.tag  ==  109){
            vc.isfname = true
            vc.sdata =  self.peepModel.fname
            
        }else{
            
            vc.isfname = false
            vc.sdata =  self.peepModel.lName
        }
        
        
        
        
        let nav1 = UINavigationController()
        
        nav1.viewControllers = [vc]
        
        //                    self.navigationController?.pushViewController(vc,
        //                                                                  animated: true)
        //
        self.present(nav1, animated: true, completion: nil)
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "peg") as! pegsViewController
//        self.present(vc, animated: true, completion: nil)
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
        if(place == "First Name"){
           myButton.tag = 109
        }else{
            myButton.tag = 110
            
        }
        myButton.addTarget(self, action:#selector(self.handlepop), for: .touchUpInside)
       
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        var size:CGFloat!
        if(indexPath.row==0  || indexPath.row==1){
            size = 90.0
        }
       
        if(indexPath.row==2){
            size = 90.0
        }
        if(indexPath.row==3){
            size = 90.0
        }
        if(indexPath.row==4){
            size = 208.0
        }
        if(indexPath.row==5){
            size = 77.0
        }
        
        
        
        
        
        
        return size;
        
        
    }
      @objc func caneUploadRequest(sender:UIButton) {
       self.clearData()
    }
    func clearData(){
        self.peepModel = addpeepModel(data: ["fName":"","lName":"","email":"","groupid":"","image":""] as [String : AnyObject])!
        self.upimg = nil;
        
        self.tableView.reloadData();
    }
     @objc func myImageUploadRequest(sender:UIButton) {
  
        
        if(self.peepModel.fname.count>0 && self.peepModel.lName.count>0 && self.peepModel.image.count>0){
            JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
            let defaults = UserDefaults.standard
            let userId = defaults.string(forKey: "uid")
          
            
            var uid = ""
            if let id = userId {
                uid = id
            }
            
            var pegs = "";
            
            
            
            if(self.fpeg.count>0 && self.lpeg.count>0){
                let fresult = self.fpeg.replacingOccurrences(of: "-", with: ",",
                                                             options: NSString.CompareOptions.literal, range:nil)
                let lresult = self.lpeg.replacingOccurrences(of: "-", with: ",",
                                                             options: NSString.CompareOptions.literal, range:nil)
                
                pegs = fresult + "," + lresult
                
            }else{
                if(self.fpeg.count>0){
                    let fresult = self.fpeg.replacingOccurrences(of: "-", with: ",",
                                                                 options: NSString.CompareOptions.literal, range:nil)
                    pegs = fresult
                }
                if(self.fpeg.count>0){
                    let lresult = self.lpeg.replacingOccurrences(of: "-", with: ",",
                                                                 options: NSString.CompareOptions.literal, range:nil)
                    pegs = lresult
                }
                
            }
            
            
            let parameters = [
                "userId": uid,
                "firstname": self.peepModel.fname,
                "lastname": self.peepModel.lName,
                "email": self.peepModel.email,
                "groupId": self.peepModel.groupid,
                "pegs":pegs
            ]
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(UIImageJPEGRepresentation(self.upimg, 0.3)!, withName: "photo", fileName: "swift.jpeg", mimeType: "image/jpeg")
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:"http://api.getpeeps.com/addpeep")
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    
                    upload.responseJSON { response in
                        print(response.result)
                         JustHUD.shared.hide()
                        
                        
                        
                                                    do {
                                                        let homrres:addpeepRootClass = try JSONDecoder().decode(addpeepRootClass.self, from: response.data!)
                        
                                                        if(homrres.success)!{
                        
                        
                        
                        
                        
                        
                                                                                    self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                                                            self.clearData()
                        
                        
                                                        }else{
                        
                                                                                    self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                                                                                    JustHUD.shared.hide()
                        
                                                        }
                        
                                                    } catch {
                                                        print(error)
                        
                                                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: error.localizedDescription);
                                                        JustHUD.shared.hide()
                                                    }
                        

                        
                    }
                    
                case .failure(let encodingError):
                 
                                            self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: encodingError.localizedDescription);
                                            JustHUD.shared.hide()
                    
                }
            }
        }
    
        
    
    }

}

