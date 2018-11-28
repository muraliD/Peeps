//
//  PeepDetailViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 8/5/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//
public extension UIButton {
    
    func alignTextBelow1(spacing: CGFloat = 1.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsetsMake(spacing-20, -imageSize.width, -(imageSize.height), 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedStringKey.font: self.titleLabel!.font])
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, -6, -titleSize.width)
        }
    }
    
}
import UIKit
import MIBadgeButton
import Alamofire
import AlamofireImage
class roundCell: UITableViewCell {
    
    @IBOutlet  var imageViews: UIImageView!
    @IBOutlet  var btn: UIButton!
    @IBOutlet  var namelbl: UILabel!
     @IBOutlet  var liklo: UIImageView!
    
    @IBOutlet weak var btn11: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageViews.clipsToBounds = true
        self.imageViews.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageViews.setRounded()
        
        
        
    }
    
    
}
class pdetCell: UITableViewCell {
    
    @IBOutlet  var imageViews: UIImageView!
    @IBOutlet  var txt: UITextView!
    @IBOutlet  var btn: UIButton!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
         self.imageViews.clipsToBounds = true
        self.imageViews.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageViews.setRounded()
       
        
        
    }
    
   
}

class PeepDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var ResultsArray:NSArray = []
     var pegsArray:NSArray = []
     var nodesArray:NSArray = []
 
    @IBOutlet weak var topImgView: UIImageView!
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var Lname: UITextField!
    @IBOutlet weak var Fname: UITextField!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var footerView: UIView!
    var currentindex1:Int!
    var currentindex2:Int!
    var peepid:String!
    var peepname:String!
    var pegnames:String!
    var currentNode:detpeepNode!
    
    
    
    public var topDistance : CGFloat{
        get{
           
                let barHeight=self.navigationController?.navigationBar.frame.height ?? 0
                let statusBarHeight = UIApplication.shared.isStatusBarHidden ? CGFloat(0) : UIApplication.shared.statusBarFrame.height
                return barHeight + statusBarHeight
           
        }
    }
    func SetBackBarButtonCustom()
    {
       
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "la-29"), for: UIControlState())
        btnLeftMenu.addTarget(self, action: #selector(self.onClcikBack), for: UIControlEvents.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        let mySegmentedControl = UISegmentedControl (items: ["One","Two","Three","four"])
        
        let xPostion:CGFloat = 10
        let yPostion:CGFloat = 150
        let elementWidth:CGFloat = 300
        let elementHeight:CGFloat = 30
        
        mySegmentedControl.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
        
        // Make second segment selected
        mySegmentedControl.selectedSegmentIndex = 1
        
        //Change text color of UISegmentedControl
        mySegmentedControl.tintColor = UIColor.yellow
        
        //Change UISegmentedControl background colour
        mySegmentedControl.backgroundColor = UIColor.black
        
        // Add function to handle Value Changed events
//        mySegmentedControl.addTarget(self, action: #selector(ViewController.segmentedValueChanged(_:)), for: .valueChanged)
        
       // self.navigationItem.titleView = mySegmentedControl
    }
    
    @objc func onClcikBack()
    {
        _ = self.dismiss(animated: true, completion: nil)
    }
    @IBAction func back(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        self.getpeepsDetails();
    }
    
    func nodelocked(){
        
        
        
        if let node = currentNode {
            
            if(node.isLocked == true){
                self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "current Node already locked");
            }else{
                JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
                
                let headers = [
                    "Content-Type": "application/x-www-form-urlencoded"
                ]
                
                let defaults = UserDefaults.standard
                let userId = defaults.string(forKey: "uid")
                var parameters: [String: Any]
                parameters = [:]
                
                var uid = ""
                var pid = ""
                var nid = ""
                var name = ""
                if let id = userId {
                    uid = id
                }
                if let id = peepid {
                    pid = id
                }
                if let id = node.id {
                    nid = id
                }
                if let names = node.peg {
                    name = names
                }
                
                parameters = ["userId":uid,"peepId": pid,"nodeId":nid,"node":name]
                
                
                
                Alamofire.request(APPURL.locknodeApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
                    
                    switch(response.result) {
                    case.success:
                        JustHUD.shared.hide()
                        
                        
                        
                        do {
                            let homrres:nodeactRootClass = try JSONDecoder().decode(nodeactRootClass.self, from: response.data!)
                            
                            if(homrres.success)!{
                                
                                //                            var resdata:nodeactResponseData = homrres.responseData as! nodeactResponseData
                                
                                
                                
                                self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "successfully locked node");
                                JustHUD.shared.hide()
                                
                                
                            }else{
                                
                                self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "failed locked node");
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
            
        }else{
            
            self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "No nodes Available to this Peep");
        }
        
    }
    func nodeliked(){
        if let node = currentNode {
            if(node.isLiked == true){
                self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "current Node already Liked");
            }else{
            
            
            JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
            
            let headers = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            
            let defaults = UserDefaults.standard
            let userId = defaults.string(forKey: "uid")
            var parameters: [String: Any]
            parameters = [:]
            
            var uid = ""
            var pid = ""
            var nid = ""
            var name = ""
            if let id = userId {
                uid = id
            }
            if let id = peepid {
                pid = id
            }
            if let id = node.id {
                nid = id
            }
            if let names = node.peg {
                name = names
            }
            
            parameters = ["userId":uid,"peepId": pid,"nodeId":nid,"node":name]
            
            
            
            Alamofire.request(APPURL.likenodeApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case.success:
                    JustHUD.shared.hide()
                    
                    
                    
                    do {
                        let homrres:nodeactRootClass = try JSONDecoder().decode(nodeactRootClass.self, from: response.data!)
                        
                        if(homrres.success)!{
                            
                            //                            var resdata:nodeactResponseData = homrres.responseData as! nodeactResponseData
                            
                            
                            
                            self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "successfully lked node");
                            JustHUD.shared.hide()
                            
                            
                        }else{
                            
                            self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "failed like node");
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
        }else{
            
            self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "No nodes Available to this Peep");
        }
    }
    func getpeepsDetails() {
        
       
        
        
        
        JustHUD.shared.showInView(view: view, withHeader: "Loading", andFooter: "Please wait...")
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let defaults = UserDefaults.standard
        let userId = defaults.string(forKey: "uid")
        var parameters: [String: Any]
        parameters = [:]
        
        var uid = ""
        var pid = ""
        
        if let id = userId {
            uid = id
        }
        if let id = peepid {
            pid = id
        }
        
        parameters = ["userId":uid,"peepId": pid]
        
        
        
        Alamofire.request(APPURL.dpeepsApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
                
                
                
                do {
                    let homrres:detpeepRootClass = try JSONDecoder().decode(detpeepRootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        
                        
                     
                        self.ResultsArray = homrres.peepDetails! as NSArray
                         self.pegsArray = homrres.pegs! as NSArray
                        self.tableView.reloadData();
                        self.currentindex1 = 0;
                       self.currentindex2 = 0;
                        //                        let usermodel:peepsModelResponseData = userdata[0] as! peepsModelResponseData
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
        self.pegnames = ""
        self.SetBackBarButtonCustom();
        self.title = self.peepname;
      self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height:  self.view.frame.size.height-60)
        self.footerView.frame = CGRect(x: 0, y: self.view.frame.size.height - self.topDistance*2, width: self.view.frame.size.width, height: 60)
      
        

       self.tableView.delegate = self;
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "detailPeercell", bundle: nil), forCellReuseIdentifier: "detailPeercell")
         self.tableView.register(UINib(nibName: "detailpeerbot", bundle: nil), forCellReuseIdentifier: "detailpeerbot")
         self.tableView.register(UINib(nibName: "roundCell", bundle: nil), forCellReuseIdentifier: "roundCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
     
        self.tableView.allowsSelection = false;
        var x = 0;
        
        let inputArray = [["name":"AddNode","img":"tab4"],["name":"LockNode","img":"tab5"],["name":"LikeNode","img":"tab6"],["name":"EditNode","img":"tab7"]];
        
        
        var index = -1;
        for item in inputArray {
            
            index = index+1
            
            let view1 = UIView(frame: CGRect(x: CGFloat(x), y: 0, width: self.view.frame.size.width/4, height: footerView.frame.size.height));
            x = x + Int(view1.frame.size.width)
            //            view1.backgroundColor = UIColor(red: 204.0/255.0, green:104.0/255.0, blue: 181.0/255.0, alpha: 1.0)
            
            //        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            //        backgroundImage.image = UIImage(named: "header_gadient.png")
            //        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
            //       view1.insertSubview(backgroundImage, at: 0)
            
            view1.backgroundColor = UIColor(patternImage: UIImage(named:"header_gadient.png")!)
            
            
            //            vLayout.addSubview(view1);
            
            view1.layer.borderColor = UIColor.white.cgColor
            
            
            view1.layer.borderWidth = 1.0
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            footerView.addSubview(view1)
            
            
            
            
            
            let myButton :MIBadgeButton = MIBadgeButton.init();
            //Set a frame for the button. Ignored in AutoLayout/ Stack Views
            
            myButton.backgroundColor = UIColor.clear
            
            
            let whe = Int(view1.frame.size.width) - Int(view1.frame.size.height)
            let pos = whe/2;
            
            myButton.frame = CGRect(x:  CGFloat(pos), y: 0, width: view1.frame.size.height, height: view1.frame.size.height);
            myButton.tag = index
            myButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
            
            
            
            if(item["name"]=="MyPeeps"){
                myButton.badgeString = "120"
                
                myButton.badgeEdgeInsets = UIEdgeInsetsMake(22, 0, 0, 10)
                
                myButton.badgeTextColor = UIColor.white
                myButton.badgeBackgroundColor = UIColor.black
            }
            
            
            
            
            myButton.setTitle(item["name"], for: .normal)
            myButton.setTitleColor(UIColor.white, for: .normal)
            myButton.setImage(UIImage(named:item["img"]!), for: .normal)
            myButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
            
            
            
            if((index==0) || (index == 3) || (index == 2)){
                 myButton.alignTextBelow1()
            }else{
                  myButton.alignTextBelow()
            }
           
            //Set background color
            //            myButton.layer.borderColor = UIColor.white.cgColor
            //
            //
            //            myButton.layer.borderWidth = 2.0
            
            
            
            view1.addSubview(myButton)
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
        
        
        // remove default border
        //        tabbar.frame.size.width = self.view.frame.width
        //        tabbar.frame.origin.x = -2
        
        // Do any additional setup after loading the view.
    }
    @objc func buttonClicked(sender:UIButton) {
        
        if(sender.tag == 0){
            let vc = storyboard?.instantiateViewController(withIdentifier: "anode") as! AddNodeTableViewController
            
            vc.peepid = self.peepid
            vc.peepname = self.peepname
            vc.type = "new"
            
            vc.pegname  = self.pegnames
            self.navigationController?.pushViewController(vc,
                                                          animated: true)
            
        }
        if(sender.tag == 1){
            self.nodelocked()
        }
        if(sender.tag == 2){
            self.nodeliked()
        }
        if(sender.tag == 3){
            if let node = self.currentNode {
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "anode") as! AddNodeTableViewController
                vc.peepid = self.peepid
                vc.peepname = self.peepname
                vc.currentNode = node
                vc.type = "edit"
                vc.pegname  = self.pegnames
                self.navigationController?.pushViewController(vc,
                                                              animated: true)
            }
                
            
            
        }
        
       
//        self.present(vc, animated: true, completion: nil)
        
    }
     @objc func intbuttonClicked(sender:UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "int1") as! Intract1TableViewController
         vc.peepid = self.peepid
                    self.navigationController?.pushViewController(vc,
                                                                  animated: true)
        
        
        
        
//        self.present(vc, animated: true, completion: nil)
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(self.ResultsArray.count>0 && self.pegsArray.count>0){
        return 3
        }else{
            if(self.ResultsArray.count>0){
            return 1
            }else{
                return 0;
            }
        }
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
       
       
//        var nodesd:Array = pegs.nodes!
        
        if(indexPath.row==0){
//        cell = tableView.dequeueReusableCell(withIdentifier: "detailPeercell")
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "detailPeercell", for: indexPath)
                as! pdetCell
          
            
             cell1.txt.layer.borderWidth = 1
             cell1.txt.layer.borderColor = UIColor.lightGray.cgColor
            cell1.txt.layer.cornerRadius = 10.0;
            cell1.txt.isEditable = false
//             let prodImg:UIImageView=(cell1.viewWithTag(888) as? UIImageView)!
            cell1.imageViews.setRounded();
            let peepdet:detpeepPeepDetail = self.ResultsArray[0] as! detpeepPeepDetail;
            cell1.txt.text = peepdet.aboutMe!
            Alamofire.request(peepdet.profilePic!).responseImage { response in
                
                if let imagess = response.result.value {
                    //                Spinner.isHidden = true
                    //                Spinner.stopAnimating()
                    cell1.imageViews.image = imagess
                    
                }else{
                    
                    //                Spinner.isHidden = true
                    //                Spinner.stopAnimating()
                    //                imageview.image = UIImage(named: "avatar")
                    
                    
                }
                
            }
            
            
//            let intBtn:UIButton=(cell1.viewWithTag(980) as? UIButton)!
            cell1.btn.addTarget(self, action:#selector(self.intbuttonClicked), for: .touchUpInside)
            
            return cell1;
        }else{
            var cell:UITableViewCell!
            let pegs = self.pegsArray[self.currentindex1] as! detpeepPeg
            
            self.nodesArray = pegs.nodes! as NSArray
            
            
            if(indexPath.row==1){
                cell = tableView.dequeueReusableCell(withIdentifier: "detailpeerbot")
                let btn11:UIButton=(cell.viewWithTag(301) as? UIButton)!
                let btn12:UIButton=(cell.viewWithTag(303) as? UIButton)!
                let btn21:UIButton=(cell.viewWithTag(401) as? UIButton)!
                let btn22:UIButton=(cell.viewWithTag(403) as? UIButton)!
                let lbl:UILabel=(cell.viewWithTag(302) as? UILabel)!
                let lbl1:UILabel=(cell.viewWithTag(402) as? UILabel)!
                let baseview:UIView=(cell.viewWithTag(546))!
                
                
                btn11.isHidden = false
                btn12.isHidden = false
                btn21.isHidden = false
                btn22.isHidden = false
                lbl.isHidden = false
                lbl1.isHidden = false
               
                baseview.isHidden = false
                
                
                
                if(self.nodesArray.count > 0  || (pegs.peg?.count)!>0  ){
                    
                    if(self.pegsArray.count>0 && self.currentindex1>0){
                        btn11.isEnabled = true
                    }else{
                        btn11.isEnabled = false
                    }
                    
                    if(self.currentindex1 == self.pegsArray.count-1){
                        btn12.isEnabled = false
                    }else{
                        btn12.isEnabled = true
                    }
                    
                    
                        lbl.text = pegs.peg
                       pegnames = pegs.peg
                    if( self.nodesArray.count>0){
                        
                        btn21.isHidden = false
                        btn22.isHidden = false
                        lbl.isHidden = false
                        lbl1.isHidden = false
                        
                        if(self.nodesArray.count>0 && self.currentindex2>0){
                            btn21.isEnabled = true
                        }else{
                            btn21.isEnabled = false
                        }
                        if(self.currentindex2 == self.nodesArray.count-1){
                            btn22.isEnabled = false
                        }else{
                            btn22.isEnabled = true
                        }
                        
                    
                        lbl1.text = String(self.currentindex2+1)+"/"+String(self.nodesArray.count)
                    }else{
                        btn21.isHidden = true
                        btn22.isHidden = true
                   
                        lbl1.isHidden = true
                        
                    }
                    
                    
                    
                    
                    
                    
                    btn11.addTarget(self, action:#selector(self.buttonClicked11), for: .touchUpInside)
                    btn12.addTarget(self, action:#selector(self.buttonClicked12), for: .touchUpInside)
                    btn21.addTarget(self, action:#selector(self.buttonClicked21), for: .touchUpInside)
                    btn22.addTarget(self, action:#selector(self.buttonClicked22), for: .touchUpInside)
                   
                }else{
                    
                    btn11.isHidden = true
                    btn12.isHidden = true
                    btn21.isHidden = true
                    btn22.isHidden = true
                    lbl.isHidden = true
                    lbl1.isHidden = true
                    lbl.text = ""
                    lbl1.text = ""
                    baseview.isHidden = true
                    
                }
               
                
            }
            if(indexPath.row==2){
                
//                cell = tableView.dequeueReusableCell(withIdentifier: "roundCell", for: indexPath)
//                    as! roundCell
                
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "roundCell", for: indexPath)
                                  as! roundCell
                
                cell1.namelbl.text = ""
                cell1.namelbl.isHidden = true
                cell1.liklo.isHidden = true
                
                
            
                
                cell1.imageViews.setRounded()
                
                
               
                //            let _:UIView=(cell.viewWithTag(30))!
                
//                let prodImg:UIImageView=(cell.viewWithTag(301) as? UIImageView)!
               if(self.nodesArray.count>0 ){
                let nodes = self.nodesArray[self.currentindex2] as! detpeepNode
                 cell1.imageViews.isHidden = false
               self.currentNode = nodes
                
                cell1.namelbl.text = nodes.descriptionField
                cell1.namelbl.isHidden = false
                cell1.liklo.isHidden = false
                if(nodes.isLocked == true && nodes.isLiked == true){
                     cell1.liklo.image = UIImage(named: "slImage")
                }
                if(nodes.isLocked == true && nodes.isLiked != true){
                      cell1.liklo.image = UIImage(named: "lock")
                }
                if(nodes.isLocked != true && nodes.isLiked == true){
                      cell1.liklo.image = UIImage(named: "like")
                }
                if(nodes.isLocked == false && nodes.isLiked == false){
                     cell1.liklo.isHidden = true
                }
              
                
                //            let width = prodview.frame.size.width - prodImg.frame.size.width
                //
                //
                //            prodImg.frame = CGRect(x: width+(width/2), y: prodImg.frame .origin.x, width: prodImg.frame .size.width, height:prodImg.frame .size.height)
                
                
                //            prodImg.centerXAnchor.constraint(equalTo: prodview.centerXAnchor).isActive = true
                //            prodImg.centerYAnchor.constraint(equalTo: prodview.centerYAnchor).isActive = true
                
                
                
                
                //                        prodImg.layer.borderWidth = 1
                //                        prodImg.layer.masksToBounds = false
                //                        prodImg.layer.borderColor = UIColor.white.cgColor
                //                        prodImg.layer.cornerRadius = prodImg.frame.height/2
                //                        prodImg.clipsToBounds = true
                
                
                Alamofire.request(nodes.image!).responseImage { response in
                    
                    if let imagess = response.result.value {
                        //                Spinner.isHidden = true
                        //                Spinner.stopAnimating()
                        cell1.imageViews.image = imagess
                        cell1.imageViews.contentMode = UIViewContentMode.scaleAspectFit
                        
                    }else{
                        
                        //                Spinner.isHidden = true
                        //                Spinner.stopAnimating()
                        //                imageview.image = UIImage(named: "avatar")
                        
                        
                    }
                    
                    
                }
               }else{
                 self.currentNode = nil
                cell1.namelbl.text = ""
                cell1.namelbl.isHidden = true
                 cell1.liklo.isHidden = true
                
                cell1.imageViews.isHidden = true
                }
                
                
                
                
                return cell1
                
                
                //
            }
//            cell?.contentView.layer.cornerRadius = 2.0
//            cell?.contentView.layer.borderWidth = 1.0
//            cell?.contentView.layer.borderColor = UIColor.clear.cgColor
//            cell?.contentView.layer.masksToBounds = true;
//            
//            cell?.layer.shadowColor = UIColor.white.cgColor
//            cell?.layer.shadowOffset = CGSize(width:0,height: 2.0)
//            cell?.layer.shadowRadius = 2.0
//            cell?.layer.shadowOpacity = 1.0
//            cell?.layer.masksToBounds = false;
//            cell?.layer.shadowPath = UIBezierPath(roundedRect:(cell?.bounds)!, cornerRadius:(cell?.contentView.layer.cornerRadius)!).cgPath
            
            return cell
        }
       
        
        
        
        
       
        
       
        
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        var size:CGFloat!
        if(indexPath.row==0){
             size = 276.0
        }
        if(indexPath.row==1){
            size = 100.0
        }
        if(indexPath.row==2){
            size = 219.0
        }
        
        
        
        
        return size;
        
        
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     
        
        
        
        
        
    }
    @objc func buttonClicked11(sender:UIButton) {
        
        self.currentindex1 = self.currentindex1 -  1 ;
        self.currentindex2 = 0
        self.tableView.reloadData();
        
    }
    @objc func buttonClicked12(sender:UIButton) {
        
       self.currentindex1 = self.currentindex1 + 1 ;
         self.currentindex2 = 0
        self.tableView.reloadData();
    }

    @objc func buttonClicked21(sender:UIButton) {
        
        self.currentindex2 = self.currentindex2 -  1 ;
        self.tableView.reloadData();
        
    }
    @objc func buttonClicked22(sender:UIButton) {
        
        self.currentindex2 = self.currentindex2 + 1 ;
        self.tableView.reloadData();
    }
        // Do any additional setup after loading the view.
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
