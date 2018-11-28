//
//  Intract1TableViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 8/10/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import ASHorizontalScrollView
import Alamofire
import AlamofireImage
extension UIPanGestureRecognizer {
    
    public struct PanGestureDirection: OptionSet {
        public let rawValue: UInt8
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
        
        static let Up = PanGestureDirection(rawValue: 1 << 0)
        static let Down = PanGestureDirection(rawValue: 1 << 1)
        static let Left = PanGestureDirection(rawValue: 1 << 2)
        static let Right = PanGestureDirection(rawValue: 1 << 3)
    }
    
    private func getDirectionBy(velocity: CGFloat, greater: PanGestureDirection, lower: PanGestureDirection) -> PanGestureDirection {
        if velocity == 0 {
            return []
        }
        return velocity > 0 ? greater : lower
    }
    
    public func direction(in view: UIView) -> PanGestureDirection {
        let velocity = self.velocity(in: view)
        let yDirection = getDirectionBy(velocity: velocity.y, greater: PanGestureDirection.Down, lower: PanGestureDirection.Up)
        let xDirection = getDirectionBy(velocity: velocity.x, greater: PanGestureDirection.Right, lower: PanGestureDirection.Left)
        return xDirection.union(yDirection)
    }
}

class Intract1TableViewController: UITableViewController,UITextViewDelegate {
    var peepid:String!
    var peepname:String!
    var pos:String!
    var upTxt:String!
    var initialCenter = CGPoint()
    var drags:NSMutableArray = []
    var nodesArray:NSMutableArray = []
    var resArray:NSMutableArray = []
     var positionsarray:NSMutableArray = []
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        self.getIntDetails();
    }
    func getIntDetails() {
        
        
        
        
        
        JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let defaults = UserDefaults.standard
        let userId = defaults.string(forKey: "uid")
        var parameters: [String: Any]
        parameters = [:]
        
        var uid = "3"
        var pid = "12"
        
        if let id = userId {
            uid = id
        }
        if let id = peepid {
            pid = id
        }
        
        parameters = ["userId":uid,"peepId": pid]
        
        
        
        Alamofire.request(APPURL.interactApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
                
                
                
                do {
                    let homrres:inteRootClass = try JSONDecoder().decode(inteRootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        
                        
                        
                        self.nodesArray = NSMutableArray(array: homrres.nodes! as NSArray)
                        self.resArray =  NSMutableArray(array: homrres.peepDetails! as NSArray)
                        
                        
//                        self.pegsArray = homrres.pegs! as NSArray
                          self.tableView.reloadData();
//                        self.currentindex1 = 0;
//                        self.currentindex2 = 0;
                        
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pos = "";
        self.upTxt = "";

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.SetBackBarButtonCustom()
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
        
        
        self.tableView.register(UINib(nibName: "intrcell11", bundle: nil), forCellReuseIdentifier: "intrcell11")
        self.tableView.register(UINib(nibName: "intrcell12", bundle: nil), forCellReuseIdentifier: "intrcell12")
        self.tableView.register(UINib(nibName: "intrcell13", bundle: nil), forCellReuseIdentifier: "intrcell13")
          self.tableView.register(UINib(nibName: "intel14", bundle: nil), forCellReuseIdentifier: "intel14")
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(resArray.count>0){
        return 4
        }
        return 0
    }
    @objc func moveObject1(_ gesture: UIPanGestureRecognizer){
        //1. Check That We Have A Valid Draggable View
        guard let draggedObject = gesture.view else { return }
        self.initialCenter = draggedObject.center
        
        if gesture.state == .began || gesture.state == .changed {
            
//            let imgViews = draggedObject.subviews.filter{$0 is UIImageView}
//             let image = imgViews[0] as! UIImageView
            
            
         
            
            //2. Set The Translation & Move The View
            
            let translation = gesture.translation(in: self.view)
            draggedObject.center = CGPoint(x: draggedObject.center.x + translation.x, y: draggedObject.center.y + translation.y)
            gesture.setTranslation(CGPoint.zero, in: self.view)
            if(draggedObject.center.y >= 200){
                let translation = gesture.translation(in: self.view)
                draggedObject.center = CGPoint(x: draggedObject.center.x + translation.x, y: 200)
                gesture.setTranslation(CGPoint.zero, in: self.view)
            }
            if(draggedObject.center.y <= 40){
                let translation = gesture.translation(in: self.view)
                draggedObject.center = CGPoint(x: draggedObject.center.x + translation.x, y: 30)
                gesture.setTranslation(CGPoint.zero, in: self.view)
            }
            
           
            
         
            
            
           
            
            
        }else if gesture.state == .ended {
                print(draggedObject.tag)
                print("tag")
            
//            self.positionsarray.insert(draggedObject.center, at: 0)
            self.positionsarray.replaceObject(at: draggedObject.tag, with: draggedObject.center)
                
            
            
            
        }
    }
    
    @objc func moveObject(_ gesture: UIPanGestureRecognizer){
        
        //1. Check That We Have A Valid Draggable View
        guard let draggedObject = gesture.view else { return }
        self.initialCenter = draggedObject.center
        print(draggedObject.center.x)
        if gesture.state == .began || gesture.state == .changed {
            
            
            
            let direction = gesture.direction(in: gesture.view! )
            if direction.contains(.Up) {
                
                let translation = gesture.translation(in: self.view)
                draggedObject.center = CGPoint(x: self.initialCenter.x + translation.x, y: self.initialCenter.y + translation.y)
                gesture.setTranslation(CGPoint.zero, in: self.view)
                
               pos = "Up"
            }
            if direction.contains(.Down)  {
                 pos = "Down"
            }
            if direction.contains(.Right)  {
                 pos = "Right"
            }
            if direction.contains(.Left)  {
                 pos = "Left"
            }
            
            
            
            
            
            
            
            
            
            //2. Set The Translation & Move The View
           
            
            
        }else if gesture.state == .ended {
            
            
            if(pos == "Up"){
                            let imgViews = draggedObject.subviews.filter{$0 is UIImageView}
                
                            if(imgViews.count>0){
                
                
                                let image = imgViews[0] as! UIImageView
                                 print(image.tag)
                                self.nodesArray.removeObject(at: image.tag)
                                self.drags.add(image);
                            }
                
                
                
                            print(draggedObject.center.y)
                            print(self.initialCenter.y)
                if(draggedObject.center.y<255){
                    
                }else{
                    let translation = gesture.translation(in: self.view)
                    draggedObject.center = CGPoint(x: self.initialCenter.x + translation.x, y:  draggedObject.center.y + translation.y)
                    gesture.setTranslation(CGPoint.zero, in: self.view)
                    
                }
                
            }
            
            

            self.tableView.reloadData()
            
            
            
            
        }
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        if(indexPath.row==0){
            cell = tableView.dequeueReusableCell(withIdentifier: "intrcell11")
            let intBtn:UIButton=(cell.viewWithTag(44) as? UIButton)!
//            intBtn.addTarget(self, action:#selector(self.intbuttonClicked), for: .touchUpInside)
            
             let txtview:UITextView=(cell.viewWithTag(333) as? UITextView)!
            
       txtview.delegate = self
            
            txtview.layer.borderWidth = 1
            txtview.layer.borderColor = UIColor.lightGray.cgColor
            txtview.layer.cornerRadius = 10.0;
                txtview.text = self.upTxt
            
            

            
        }
        if(indexPath.row==1){
            cell = tableView.dequeueReusableCell(withIdentifier: "intrcell12")
            let dragbg:UIView=(cell.viewWithTag(500))!
             let imgview:UIImageView=(cell.viewWithTag(501) as? UIImageView)!
            let height = dragbg.frame.height
            let width = dragbg.frame.width
            
            let randomPosition = CGPoint( x:CGFloat( arc4random_uniform( UInt32( floor( width  ) ) ) ),
                                          y:CGFloat( arc4random_uniform( UInt32( floor( height ) ) ) )
            )
            if(self.drags.count>0){
               
               
                var k = -1
                var ranpos:CGPoint!
                for node in self.drags{
                    k=k+1
                    let imageview = node as! UIImageView
                    imageview.tag = k;
                    if(self.positionsarray.count>0){
                        
//                        var count:Int = self.positionsarray.count
//
//                        if(count)
                        
                        if(self.positionsarray.count != k+1){
                            let randomPosition1:CGPoint = self.positionsarray[k] as! CGPoint
                           
                             ranpos = randomPosition1
                            
                            imgview.frame = CGRect(x: randomPosition1.x, y: randomPosition1.y, width: 80, height: 80)
                             self.positionsarray.replaceObject(at: k, with: randomPosition1)
                    
                        }else{
                             ranpos = randomPosition
                            imageview.frame = CGRect(x: randomPosition.x, y: 10, width: 80, height: 80)
                            self.positionsarray.insert(ranpos, at: k);
                        }
                        
                       
                        
                        
                        
                    }else{
                         ranpos = randomPosition
                        imageview.frame = CGRect(x: randomPosition.x, y: 10, width: 80, height: 80)
                        self.positionsarray.insert(ranpos, at: k);
                        
                    }
                    
                    
                    
                    dragbg.addSubview(imageview);
                    
                    
                    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveObject1(_:)))
                    
                    imageview.addGestureRecognizer(panGesture)
                    
                    
                }
                
                
                
                
            }
            
                     let usermodel:intePeepDetail =  self.resArray [0] as! intePeepDetail
            
            Alamofire.request(usermodel.profilePic!).responseImage { response in
                
                if let imagess = response.result.value {
                    //                Spinner.isHidden = true
                    //                Spinner.stopAnimating()
                    imgview.image = imagess
                    imgview.setRounded()
                    //                            cell1.imageViews.contentMode = UIViewContentMode.scaleAspectFit
                    
                }else{
                    
                    //                Spinner.isHidden = true
                    //                Spinner.stopAnimating()
                    //                imageview.image = UIImage(named: "avatar")
                    
                    
                }
                
            }
            
            
        }
        if(indexPath.row==2){
            cell = tableView.dequeueReusableCell(withIdentifier: "intrcell13")
    
              let prodScroll:ASHorizontalScrollView=(cell.viewWithTag(444) as? ASHorizontalScrollView)!
            prodScroll.removeAllItems()
          
            prodScroll.arrangeType = .byNumber
            prodScroll.marginSettings_320 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 4.25)
            prodScroll.marginSettings_480 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 5.25)
            prodScroll.marginSettings_414 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 4.25)
            prodScroll.marginSettings_736 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 7.375)
            
            prodScroll.uniformItemSize = CGSize(width: 80, height: 120)
            //this must be called after changing any size or margin property of this class to get acurrate margin
            prodScroll.setItemsMarginOnce()
          
            var k = -1;
            for node in self.nodesArray{
                k = k+1;
                let node:inteNode =  node as! inteNode
               
                  let view1 = UIView(frame: CGRect.zero);
                
                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveObject(_:)))
               
                view1.addGestureRecognizer(panGesture)
                
                
                let imageName = "avatar"
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)
                imageView.tag = k;
                imageView.isUserInteractionEnabled = true;
                
                imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
                  imageView.contentMode = UIViewContentMode.scaleAspectFit
                view1.addSubview(imageView)
              
                
                let label:UILabel = UILabel(frame: CGRect(x: 0, y: 80, width: imageView.frame.size.width, height: 20))
                label.numberOfLines = 0
                label.textAlignment = .center
                label.backgroundColor = UIColor.white
                label.lineBreakMode = NSLineBreakMode.byWordWrapping
   
                label.text = node.node
                
            
              
                 view1.addSubview(label)
                
                let imageName1 = "uname"
               
                let image1 = UIImage(named: imageName1)
                let imageView1 = UIImageView(image: image1!)
                
                
                imageView1.frame = CGRect(x: 0, y: 100, width: 30, height: 30)
               
                view1.addSubview(imageView1)
          
                imageView.backgroundColor = UIColor.white
                imageView.isUserInteractionEnabled = true
               
         
                
                Alamofire.request(node.image!).responseImage { response in
                    
                    if let imagess = response.result.value {
                        //                actind.isHidden = true
                        //                actind.stopAnimating()
                        imageView.image = imagess
                        imageView.contentMode = UIViewContentMode.scaleAspectFit
                        imageView.setRounded()
                         imageView.contentMode = UIViewContentMode.scaleAspectFit
                        imageView.clipsToBounds = true;
                        
                        
                    }else{
                        
                        //                actind.isHidden = true
                        //               actind.stopAnimating()
                        //                imageview.image = UIImage(named: "avatar")
                        
                        
                    }
                    
                    
                }
                
                
                  prodScroll.addItem(view1)
            }
            
           
        }
        if(indexPath.row==3){
            cell = tableView.dequeueReusableCell(withIdentifier: "intel14")
            let btn11:UIButton=(cell.viewWithTag(340) as? UIButton)!
            let btn12:UIButton=(cell.viewWithTag(341) as? UIButton)!
            let btn13:UIButton=(cell.viewWithTag(342) as? UIButton)!
            btn11.addTarget(self, action:#selector(self.buttonClicked11), for: .touchUpInside)
            btn12.addTarget(self, action:#selector(self.buttonClicked12), for: .touchUpInside)
            btn13.addTarget(self, action:#selector(self.buttonClicked13), for: .touchUpInside)
           
            
        }
        cell?.contentView.layer.cornerRadius = 2.0
        cell?.contentView.layer.borderWidth = 1.0
        cell?.contentView.layer.borderColor = UIColor.clear.cgColor
        cell?.contentView.layer.masksToBounds = true;
        
        cell?.layer.shadowColor = UIColor.white.cgColor
        cell?.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell?.layer.shadowRadius = 2.0
        cell?.layer.shadowOpacity = 1.0
        cell?.layer.masksToBounds = false;
        cell?.layer.shadowPath = UIBezierPath(roundedRect:(cell?.bounds)!, cornerRadius:(cell?.contentView.layer.cornerRadius)!).cgPath
        
        return cell
    }
    func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    @objc func buttonClicked11(sender:UIButton) {
        
        if(self.upTxt.count>0 && self.drags.count>0){
            let indexPath = IndexPath(row: 1, section: 0)
            let cell = self.tableView.cellForRow(at: indexPath)
            
            
            
            let dragbg:UIView=(cell!.viewWithTag(500))!
            
            let drimage :UIImage =  self.image(with: dragbg)!
            
            
            
            
            
            
            JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
            let defaults = UserDefaults.standard
            let userId = defaults.string(forKey: "uid")
            
            
            var uid = ""
            var pid = ""
            
            var peg = ""
            
            if let id = userId {
                uid = id
            }
            if let id = self.peepid {
                pid = id
            }
            if let id = self.upTxt {
                peg = id
            }
            
            
            
            var parameters: [String: String]
            parameters = [:]
            
            
            parameters = [
                
                "userId": uid,
                "peepId": pid,
                "description":peg
                
            ]
            
            
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(UIImageJPEGRepresentation(drimage, 1)!, withName: "photo", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                //                multipartFormData.append(UIImageJPEGRepresentation(self.upimg, 1)!, withName: "sound", fileName: "ff.m4a", mimeType: "audio/m4a")
                
                //                multipartFormData.append(self.upsdata as Data, withName: "sound", fileName: "ff.mp3", mimeType: "audio/m4a")
                
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:APPURL.saveinteractimageRouteApi)
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
                            
                            //                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Node Added Successfully");
                            
                            do {
                                let homrres:intsaveRootClass = try JSONDecoder().decode(intsaveRootClass.self, from: response.data!)
                                
                                if(homrres.success)!{
                                    
                                    
                                    
                                    
                                    
                                    
                                    self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                                    
                                    
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
            self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Enter valid description and draged images");
            
        }
        
        


  
        
    }
    @objc func buttonClicked12(sender:UIButton) {
        
       
    }
    
    @objc func buttonClicked13(sender:UIButton) {
        
      
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        var size:CGFloat!
        if(indexPath.row==0){
            size = 121.0
        }
        if(indexPath.row==1){
            size = 250
        }
        if(indexPath.row==2){
            size = 130.0
        }
        if(indexPath.row==3){
            size = 60
        }
        
        
        
        
        return size;
        
        
    }
    func textViewDidChange(_ textView: UITextView) {
        self.upTxt = textView.text
    }
  
    @objc func intbuttonClicked(sender:UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "int2") as! Interact2TableViewController
        
        self.navigationController?.pushViewController(vc,
                                                      animated: true)
        
        //        self.present(vc, animated: true, completion: nil)
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
