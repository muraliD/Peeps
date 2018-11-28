//
//  AddPeerTableViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 9/10/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import Alamofire
import ContactsUI
import ASHorizontalScrollView
class AddPeerTableViewController: UITableViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CNContactPickerDelegate,UITextViewDelegate,SecondVCDelegate,selDelegate  {
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var topImgView: UIImageView!
    var peepModel:addpeerModel!
     var peepIds:String!
    var addpeepArray:NSMutableArray = []
 
    weak var delegate: SecondVCDelegate?
    var imagePicker = UIImagePickerController()
    var upimg:UIImage!
    func selectdata(_ finResultsArray: NSMutableDictionary?) {
        addpeepArray = [];
        var finalstring:String = ""
        
        let doneArray = finResultsArray?.allKeys
        
        for item in doneArray! {
            let usermodel:peepsModelResponseData = finResultsArray! [item] as! peepsModelResponseData
            addpeepArray.add(usermodel);
            
            finalstring += item as! String + ","
            
        }
        
       
        let endIndex = finalstring.index(finalstring.endIndex, offsetBy: -1)
        self.peepIds = finalstring.substring(to: endIndex)
        
        self.tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetBackBarButtonCustom();
        imagePicker.delegate = self
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
       
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
     
        
        
        self.peepModel = addpeerModel(data: ["pName":"","desc":"","image":""] as [String : AnyObject])!
        
        self.peepIds = ""
     
        
        
        
        
    }
    @objc func buttonClicked(sender:UIButton) {
        if(sender.tag == 0){
            
            self.dismiss(animated: true, completion: nil)
            self.delegate?.close!()
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
        
        
//        self.peepModel = addpeepModel(data: ["fName":contact.givenName,"lName":contact.familyName,"email":email,"groupid":"1","image":""] as [String : AnyObject])!
        
        
        self.peepModel = addpeerModel(data: ["pName":"","desc":"","image":""] as [String : AnyObject])!
        
        
        self.tableView.reloadData();
        
        
        print("WYASDFY")
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
    
    
    func SetBackBarButtonCustom()
    {
    
                let btnLeftMenu: UIButton = UIButton()
                btnLeftMenu.setImage(UIImage(named: "la-29"), for: UIControlState())
                btnLeftMenu.addTarget(self, action: #selector(self.onClcikBack), for: UIControlEvents.touchUpInside)
                btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
                let barButton = UIBarButtonItem(customView: btnLeftMenu)
                self.navigationItem.leftBarButtonItem = barButton
        
        
        self.title = "Add PeerPeeps"
        
        
        self.tableView.register(UINib(nibName: "peeAdd1", bundle: nil), forCellReuseIdentifier: "peeAdd1")
        self.tableView.register(UINib(nibName: "DAdded", bundle: nil), forCellReuseIdentifier: "DAdded")
        self.tableView.register(UINib(nibName: "PAdded", bundle: nil), forCellReuseIdentifier: "PAdded")
        self.tableView.register(UINib(nibName: "searcc", bundle: nil), forCellReuseIdentifier: "searcc")
        self.tableView.register(UINib(nibName: "imagecell", bundle: nil), forCellReuseIdentifier: "imagecell")
        self.tableView.register(UINib(nibName: "Description", bundle: nil), forCellReuseIdentifier: "Description")
        self.tableView.register(UINib(nibName: "adpeepbtn", bundle: nil), forCellReuseIdentifier: "adpeepbtn")
        
         self.tableView.register(UINib(nibName: "Addpeeps", bundle: nil), forCellReuseIdentifier: "Addpeeps")
         self.tableView.register(UINib(nibName: "peeradd1", bundle: nil), forCellReuseIdentifier: "peeradd1")
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.tableView.allowsSelection = false;
    }
    
    @objc func onClcikBack()
    {
        self.delegate?.close!()
      self.dismiss(animated: true, completion: nil);
        
        
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
        
//        if(indexPath.row==0 ){
//
//            cell = tableView.dequeueReusableCell(withIdentifier: "peeAdd1")
//            let txt1:UITextField=(cell.viewWithTag(777) as? UITextField)!
//            txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//            txt1.text = self.peepModel.fname
//            txt1.delegate = self
//            self.setPaddingView(strImgname: "pic1", txtField: txt1, place: "First Name");
//
//        }
//
//        if(indexPath.row==1){
//            cell = tableView.dequeueReusableCell(withIdentifier: "peeAdd1")
//            let txt1:UITextField=(cell.viewWithTag(777) as? UITextField)!
//            txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//            txt1.delegate = self
//            txt1.text = self.peepModel.lName
//            self.setPaddingView(strImgname: "pic1", txtField: txt1, place: "Last Name");
//
//        }
        if(indexPath.row==0){
            
            cell = tableView.dequeueReusableCell(withIdentifier: "peeAdd1")
            let txt1:UITextField=(cell.viewWithTag(777) as? UITextField)!
            let leftView = UIView()
            leftView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
            txt1.leftViewMode = .always
            txt1.leftView = leftView
            txt1.delegate = self
            txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            txt1.layer.cornerRadius = 5.0
            txt1.placeholder = "Peer Group Name"
            txt1.text = self.peepModel.pName
            
        }
        if(indexPath.row==1){
            cell = tableView.dequeueReusableCell(withIdentifier: "Description")
            let txt1:UITextView=(cell.viewWithTag(333) as? UITextView)!
            txt1.delegate = self
           
            txt1.layer.cornerRadius = 5.0
          
            txt1.text = self.peepModel.desc
            
            
            
            
        }
        if(indexPath.row==2){
            cell = tableView.dequeueReusableCell(withIdentifier: "Addpeeps")
            let btn:UIButton=(cell.viewWithTag(435) as? UIButton)!
            btn.addTarget(self, action:#selector(self.getpeeps), for: .touchUpInside)
            
            
            
//
//
//            txt1.layer.cornerRadius = 5.0
//
//            txt1.text = self.peepModel.groupid
            
            
            
            
        }
        if(indexPath.row==3){
            cell = tableView.dequeueReusableCell(withIdentifier: "peeradd1")
            
            
            
            let prodScroll:ASHorizontalScrollView=(cell.viewWithTag(444) as? ASHorizontalScrollView)!
            
            prodScroll.arrangeType = .byNumber
            prodScroll.marginSettings_320 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 4.25)
            prodScroll.marginSettings_480 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 5.25)
            prodScroll.marginSettings_414 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 4.25)
            prodScroll.marginSettings_736 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 7.375)
            
            prodScroll.uniformItemSize = CGSize(width: 80, height: 120)
            //this must be called after changing any size or margin property of this class to get acurrate margin
            prodScroll.setItemsMarginOnce()
            prodScroll.removeAllItems()
            
            
            
         
            
            
            for item in self.addpeepArray {
                
                let view1 = UIView(frame: CGRect.zero);
                
                
                let usermodel:peepsModelResponseData = item as! peepsModelResponseData
                
                let imageView = UIImageView()
                
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                imageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                imageView.clipsToBounds = true;
                imageView.layer.cornerRadius = 35.0
                imageView.backgroundColor = UIColor.white
                imageView.isUserInteractionEnabled = true
                view1.addSubview(imageView)
               
                
                
                
                
                
                
                Alamofire.request(usermodel.profilePic!).responseImage { response in
                    
                    if let imagess = response.result.value {
                        //                actind.isHidden = true
                        //                actind.stopAnimating()
                        imageView.image = imagess
                        imageView.contentMode = UIViewContentMode.scaleAspectFit
                        
                        
                    }else{
                        
                        //                actind.isHidden = true
                        //               actind.stopAnimating()
                        //                imageview.image = UIImage(named: "avatar")
                        
                        
                    }
                    
                    
                }
                
                
//                imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 120)
//                imageView.contentMode = UIViewContentMode.scaleAspectFit
//                view1.addSubview(imageView)
                
                
                let label:UILabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.origin.y+imageView.frame.size.height, width: imageView.frame.size.width, height: 20))
                label.numberOfLines = 0
                label.textAlignment = .center
                label.backgroundColor = UIColor.white
                label.lineBreakMode = NSLineBreakMode.byWordWrapping
                
                label.text = usermodel.firstName
                
                
                
                view1.addSubview(label)
                
                
                
                prodScroll.addItem(view1)
            }
//            let txt1:UITextView=(cell.viewWithTag(333) as? UITextView)!
//
//
//            txt1.layer.cornerRadius = 5.0
//
//            txt1.text = self.peepModel.groupid
            
            
            
            
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
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        print(textView.text); //the textView parameter is the textView where text was changed
        self.peepModel.desc=textView.text!
    }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        
        if let cell = textField.superview?.superview as? UITableViewCell? {
            let indexPath = self.tableView.indexPath(for: cell!)
            
            if(indexPath?.row==0){
                self.peepModel.pName=textField.text!
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
            
            if(self.peepModel.pName.count>0 ){
                self.appDelegate?.opengoogleimages(name: self.peepModel.pName)
            }else{
                self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Enter Group Name");
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        var size:CGFloat!
       
        if(indexPath.row==0){
            size = 90.0
        }
        if(indexPath.row==1){
            size = 158.0
        }
        if(indexPath.row==2){
            size = 48.0
        }
        if(indexPath.row==3){
            size = 120.0
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
    @objc func getpeeps(sender:UIButton) {
      
        let vc = storyboard?.instantiateViewController(withIdentifier: "speeps") as! selectPeepViewController
      vc.delegate = self
        let nav1 = UINavigationController()
        
        nav1.viewControllers = [vc]
        
        //                    self.navigationController?.pushViewController(vc,
        //                                                                  animated: true)
        //
        self.present(nav1, animated: true, completion: nil)
        
        
        
        
    }
    func clearData(){
//        self.peepModel = addpeepModel(data: ["fName":"","lName":"","email":"","groupid":"","image":""] as [String : AnyObject])!
//        self.upimg = nil;
//
//        self.tableView.reloadData();
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func myImageUploadRequest(sender:UIButton) {
        
        
        if(self.peepModel.pName.count>0 || self.peepModel.desc.count>0 || self.peepIds.count>0 || self.peepModel.image.count>0){
            JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
            let defaults = UserDefaults.standard
            let userId = defaults.string(forKey: "uid")
            
            
            var uid = ""
            var pids = ""
            if let id = userId {
                uid = id
            }
            if let id = self.peepIds {
                pids = id
            }
            
            let parameters = [
                "userId": uid,
                "name": self.peepModel.pName,
                "description": self.peepModel.desc,
                 "peeps": pids
            ]
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(UIImageJPEGRepresentation(self.upimg, 1)!, withName: "photo", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:"http://api.getpeeps.com/peerpeeps/add")
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
//                                self.clearData()
                                
                                
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
        }else{
            
            self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages:"Please enter valid details");
        }
        
        
        
    }
    
}

