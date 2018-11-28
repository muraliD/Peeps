//
//  AddNodeTableViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 9/1/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
class AddNodeTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate , AVAudioRecorderDelegate, AVAudioPlayerDelegate,UITextViewDelegate {
    var peepid:String!
    var peepname:String!
    var imagePicker = UIImagePickerController()
    var upimg:UIImage!
    var uptxt:String!
    var upurl:NSURL!
    var upsdata:Data!
    var currentNode:detpeepNode!
    var isRecording = false
      var isplay = false
    var isfunction:String!
    var audioRecorder: AVAudioRecorder?
    var player : AVAudioPlayer?
    var type:String!
    var pegname:String!
    var upimgstr:String!
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.upimgstr = "";
        self.uptxt = "";
//        }
         self.SetBackBarButtonCustom()
         imagePicker.delegate = self
        
        if(self.type == "new"){

          self.title = "Add Node"
            
        }else{
            
            self.title = "Node: " + self.currentNode.peg!
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func setUpUI() {
       
        // Adding constraints to Play button
       
    }
    func SetBackBarButtonCustom()
    {
      
        self.isfunction = ""
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "la-29"), for: UIControlState())
        btnLeftMenu.addTarget(self, action: #selector(self.onClcikBack), for: UIControlEvents.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
       
        self.tableView.register(UINib(nibName: "nodeimgCell", bundle: nil), forCellReuseIdentifier: "nodeimgCell")
         self.tableView.register(UINib(nibName: "nodetxt", bundle: nil), forCellReuseIdentifier: "nodetxt")
                 self.tableView.register(UINib(nibName: "nodesound", bundle: nil), forCellReuseIdentifier: "nodesound")
  
         self.tableView.register(UINib(nibName: "searcc", bundle: nil), forCellReuseIdentifier: "searcc")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.tableView.allowsSelection = false;
      
    }
    
    @objc func onClcikBack()
    {
       _ = self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    @objc func tapDetected() {
   
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
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
//        self.peepModel.image = imageStr;
        
        self.upimgstr = imageStr
        
        upimg = info[UIImagePickerControllerOriginalImage] as? UIImage
        let indexPath = IndexPath(item: 0, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .top)
        //self.tableView.reloadData()
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        if(indexPath.row==0 ){
            cell = tableView.dequeueReusableCell(withIdentifier: "nodeimgCell")
             let imgview:UIImageView=(cell.viewWithTag(405) as? UIImageView)!
        
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(AddNodeTableViewController.tapDetected))
            imgview.isUserInteractionEnabled = true
            imgview.addGestureRecognizer(singleTap)
            
            
            if(self.type == "new"){
                
                if( self.upimgstr.count != 0)
                {
                if let img = self.upimg {
                    
                    imgview.image = img
                
                }
            }
                
            }
                else{
                print(self.upimgstr.count)
                if( self.upimgstr.count == 0)
                {
                    Alamofire.request(currentNode.image!).responseImage { response in
                        
                        if let imagess = response.result.value {
                            //                Spinner.isHidden = true
                            //                Spinner.stopAnimating()
                            imgview.image = imagess
                            self.upimg  = imagess
                            self.upimgstr = "added"
                            //                            cell1.imageViews.contentMode = UIViewContentMode.scaleAspectFit
                            
                        }else{
                            
                            //                Spinner.isHidden = true
                            //                Spinner.stopAnimating()
                            //                imageview.image = UIImage(named: "avatar")
                            
                            
                        }
                        
                    }
                    
                    
                }else{
                    
                    if let img = self.upimg {
                        
                        imgview.image = img
                       
                    }
                    
                }
                
                

                }

            
       
            
            
            
            //Action
            
           
        }
        if(indexPath.row==1 ){
            cell = tableView.dequeueReusableCell(withIdentifier: "nodetxt")
             let txtview:UITextView=(cell.viewWithTag(345) as? UITextView)!
            txtview.delegate = self
            if(self.type == "edit"){
                if(self.uptxt.count>0){
                   txtview.text = uptxt
                }else{
                   txtview.text = currentNode.descriptionField
                    
                }
            
            }else{
                txtview.text = uptxt
            }
            
        }
       
            
        if(indexPath.row==2 ){
            cell = tableView.dequeueReusableCell(withIdentifier: "searcc")
            let okbtn:UIButton=(cell.viewWithTag(567) as? UIButton)!
              okbtn.addTarget(self, action:#selector(self.addnode), for: .touchUpInside)
             let image = UIImage(named: "add")
            okbtn.setImage(image, for: .normal)
        }
        
        return cell
    }
    
     @objc func addnode(sender:UIButton) {
        
        var isnoerror:Bool = false;
        
         if(self.uptxt.count > 0 && self.upimgstr.count > 0){
            
            JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
            let defaults = UserDefaults.standard
            let userId = defaults.string(forKey: "uid")
            
            
            var uid = ""
            var pid = ""
            var nid = ""
            var peg = ""
            var url = ""
            if let id = userId {
                uid = id
            }
            if let id = self.peepid {
                pid = id
            }
            
            
            if let id = self.uptxt {
                peg = id
            }
            
            
            
            var parameters: [String: String]
            parameters = [:]
            
            
            if(self.type == "new"){
                
                
                parameters = [
                    "userId": uid,
                    "peepId": pid,
                    "peg": self.pegname,
                    "description":peg
                    
                ]
                url = APPURL.addnodeApi
            }else{
                if let id = self.currentNode.id {
                    nid = id
                }
                var data = ""
                if let id = self.uptxt {
                    data = id
                }
                
                parameters = [
                    "nodeId":nid,
                    "userId": uid,
                    "peepId": pid,
                    "peg": self.pegname,
                    "description":data
                    
                ]
                url = APPURL.editnodeApi
            }
            
            
            
            
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(UIImageJPEGRepresentation(self.upimg, 1)!, withName: "photo", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                //                multipartFormData.append(UIImageJPEGRepresentation(self.upimg, 1)!, withName: "sound", fileName: "ff.m4a", mimeType: "audio/m4a")
                multipartFormData.append(UIImageJPEGRepresentation(self.upimg, 1)!, withName: "sound", fileName: "swift_file.mp3", mimeType: "audio/m4a")
                //                multipartFormData.append(self.upsdata as Data, withName: "sound", fileName: "ff.mp3", mimeType: "audio/m4a")
                
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:url)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    
                    upload.responseJSON { response in
                        print(response.result)
                        switch(response.result) {
                        case.success:
                            JustHUD.shared.hide()
                            
                            
                            
                            do {
                                let homrres:addnodeRootClass = try JSONDecoder().decode(addnodeRootClass.self, from: response.data!)
                                
                                if(homrres.success)!{
                                    
                                    
                                    
                                    
                                    
                                    
                                    self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Node Added SuccessFully");
                                    
                                    
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
                    
                case .failure(let encodingError):
                    
                    self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: encodingError.localizedDescription);
                    JustHUD.shared.hide()
                    
                }
            }
            
            
            
            
            
         }else{
            
            
             self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Enter Valid image and text");
        }
        
    }
        @objc func soundClicked(sender:UIButton) {
            if isRecording {
                
                finishRecording(sender: sender)
            }else {
                
                startRecording(sender: sender)
            }
        }
        
    
        // Path for saving/retreiving the audio file
        func getAudioFileUrl() -> URL{
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docsDirect = paths[0]
            let audioUrl = docsDirect.appendingPathComponent("recording.m4a")
            return audioUrl
        }
        
        func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
            
            
            
            
            
            if flag {
               
            }else {
               
            }
            self.tableView.reloadData();
//            playButton.isEnabled = true
        }
        
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            if flag {
                
            }else {
                // Playing interrupted by other reasons like call coming, the sound has not finished playing.
            }
//            recordButton.isEnabled = true
        }
    func startRecording(sender:UIButton) {
        //1. create the session
        let session = AVAudioSession.sharedInstance()
        
        do {
            // 2. configure the session for recording and playback
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try session.setActive(true)
            // 3. set up a high-quality recording session
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            // 4. create the audio recording, and assign ourselves as the delegate
            audioRecorder = try AVAudioRecorder(url: getAudioFileUrl(), settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            
            //5. Changing record icon to stop icon
            isRecording = true
             let image = UIImage(named: "stops")
         sender.setImage(image, for: .normal)
       self.isfunction = "starts"
//            sender.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
      
        }
        catch let error {
            // failed to record!
        }
    }
    
    // Stop recording
    func finishRecording(sender:UIButton) {
        audioRecorder?.stop()
        isRecording = false
//        sender.imageEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20)
        let image = UIImage(named: "play")
         self.isfunction = "stops"
        sender.setImage(image, for: .normal)
    }
    
    func textViewDidChange(_ textView: UITextView) {
         uptxt = textView.text
    }
//    func getAudioFileUrl() -> URL{
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let docsDirect = paths[0]
//        let audioUrl = docsDirect.appendingPathComponent("recording.m4a")
//        return audioUrl
//    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        var size:CGFloat!
        if(indexPath.row==0){
            size = 187.0
        }
        if(indexPath.row==1){
            size = 187.0
        }
        
        if(indexPath.row==2){
            size = 128.0
        }
        
        
        
        
        
        
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
