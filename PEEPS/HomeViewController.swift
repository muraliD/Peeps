//
//  HomeViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 8/3/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

    
public extension UIButton {
    
    func alignTextBelow(spacing: CGFloat = 1.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsetsMake(spacing, -imageSize.width, -(imageSize.height), 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedStringKey.font: self.titleLabel!.font])
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, -6, -titleSize.width)
        }
    }
    
}
import UIKit
import MIBadgeButton
import Alamofire
import ASHorizontalScrollView
class HomeViewController: UIViewController ,UIGestureRecognizerDelegate{
    @IBOutlet weak var actind: UIActivityIndicatorView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var hscroll: ASHorizontalScrollView!
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var topImgView: UIImageView!
    @IBOutlet weak var Lname: UITextField!
    @IBOutlet weak var Fname: UITextField!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var footerView: UIView!
   var pcount: Int!
    var intercactArray:NSArray = []
    func makeButtonWithText(text:String) -> UIButton {
        let myButton = UIButton(type: UIButtonType.system)
        //Set a frame for the button. Ignored in AutoLayout/ Stack Views
        myButton.frame = CGRect(x: 30, y: 30, width: 150, height: 150)
        //Set background color
        myButton.backgroundColor = UIColor.blue
        return myButton
        
    }
    
    
   
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.actind.isHidden = false
        self.actind.startAnimating()
        
   
       
      
        let model:userDeatailInteract = self.intercactArray[(sender.view?.tag)!] as! userDeatailInteract
        
        self.Fname.text = model.firstName
        self.Lname.text = model.lastName
        
        
        Alamofire.request(model.interactImage!).responseImage { response in
            
            if let imagess = response.result.value {
                
                self.actind.isHidden = true
                self.actind.stopAnimating()
           
                self.profileImg.image = imagess
               
            }else{
                self.actind.isHidden = true
                self.actind.stopAnimating()
              
            }
            
            
        }
        
        
    }
    func getuserDetails() {
        
        self.actind.isHidden = true
        self.actind.stopAnimating()
        
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
        
    
        
 
        
        Alamofire.request(APPURL.detailsApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
               
                
                
                do {
                    let homrres:userDeatailRootClass = try JSONDecoder().decode(userDeatailRootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        
                        
                        let userdata:NSArray = homrres.userDetails! as NSArray
                        let usermodel:userDeatailUserDetail = userdata[0] as! userDeatailUserDetail
                        
                        self.Fname.text = usermodel.firstName
                         self.Lname.text = usermodel.lastName
                        self.pcount = usermodel.peepCount
                        
                        
                        
                        Alamofire.request(usermodel.profilePic!).responseImage { response in
                            
                            if let imagess = response.result.value {
                                
                                self.actind.isHidden = true
                                self.actind.stopAnimating()
                                
                                self.profileImg.image = imagess
                                
                            }else{
                                self.actind.isHidden = true
                                self.actind.stopAnimating()
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                        self.topImgView.frame.size.width = self.view.frame.size.width
                        self.topImgView.isUserInteractionEnabled = true
                        let imageName = "icon-76"
                        let image = UIImage(named: imageName)
                        let imageView = UIImageView(image: image!)
                        imageView.contentMode = UIViewContentMode.scaleAspectFit
                        imageView.frame = CGRect(x: -10, y: 0, width: (image?.size.width)!, height: self.topImgView.frame.size.height)
                        self.topImgView.addSubview(imageView)
                        let label = UILabel(frame: CGRect(x: imageView.frame.size.width, y: 0, width: 200, height: self.topImgView.frame.size.height))
                        
                        label.textAlignment = .left
                        label.text = "Peers"
                        label.font = UIFont.init(name: "Showcard Gothic", size: 30)
                        label.textColor = UIColor.white
                        self.topImgView.addSubview(label)
                        
                        
                        self.profileImg.contentMode = UIViewContentMode.scaleAspectFit
                        self.profileImg.layer.cornerRadius = 60
                        self.profileImg.clipsToBounds = true
                        
                        
                        
                        let imageName1 = "set"
                        let image1 = UIImage(named: imageName1)
                        
                        let myButton = UIButton(type: UIButtonType.custom)
                        //Set a frame for the button. Ignored in AutoLayout/ Stack Views
                        myButton.setImage(image1, for: .normal)
                        myButton.frame = CGRect(x: self.view.frame.size.width-(image1?.size.width)!-10, y: 5, width: (image1?.size.width)!, height: (image1?.size.width)!)
                        myButton.addTarget(self, action:#selector(self.buttonClicked1), for: .touchUpInside)
                        //Set background color
                        myButton.backgroundColor = UIColor.clear
                        self.topImgView.addSubview(myButton)
                        
                        //        mpeeps
                      
                        
                        
                        
                        var x = 0;
                        
                        let inputArray = [["name":"MyPeeps","img":"tab1-40"],["name":"PeerPeers","img":"tab2-40"],["name":"Flow20","img":"tab3-40"]];
                        
                        
                        var index = -1;
                        for item in inputArray {
                            
                            index = index+1
                            
                            let view1 = UIView(frame: CGRect(x: CGFloat(x), y: 0, width: self.view.frame.size.width/3, height: self.footerView.frame.size.height));
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
                           
                            self.footerView.addSubview(view1)
                            
                            
                            let myButton :MIBadgeButton = MIBadgeButton.init();
                            //Set a frame for the button. Ignored in AutoLayout/ Stack Views
                            
                            myButton.backgroundColor = UIColor.clear
                            
                            
                            let whe = Int(view1.frame.size.width) - Int(view1.frame.size.height)
                            let pos = whe/2;
                            
                            myButton.frame = CGRect(x:  CGFloat(pos), y: 0, width: view1.frame.size.height, height: view1.frame.size.height);
                            myButton.tag = index
                            myButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
                            
                            
                            
                            if(item["name"]=="MyPeeps"){
                                myButton.badgeString = String(self.pcount)
                                
                                myButton.badgeEdgeInsets = UIEdgeInsetsMake(22, 0, 0, 10)
                                
                                myButton.badgeTextColor = UIColor.white
                                
                                myButton.badgeBackgroundColor = UIColor.black
                            }
                            
                            
                            
                            
                            myButton.setTitle(item["name"], for: .normal)
                            myButton.setTitleColor(UIColor.white, for: .normal)
                            myButton.setImage(UIImage(named:item["img"]!), for: .normal)
                            myButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
                            
                            
                            
                            
                            myButton.alignTextBelow()
                            //Set background color
                            //            myButton.layer.borderColor = UIColor.white.cgColor
                            //
                            //
                            //            myButton.layer.borderWidth = 2.0
                            
                            
                            
                            view1.addSubview(myButton)
                            
                            
                        }
                        
                        self.hscroll.arrangeType = .byNumber
                        
                        self.hscroll.marginSettings_320 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 4.25)
                        self.hscroll.marginSettings_480 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 5.25)
                        self.hscroll.marginSettings_414 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 4.25)
                         self.hscroll.marginSettings_736 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 7.375)
                        self.hscroll.removeAllItems()
                         self.hscroll.uniformItemSize = CGSize(width: 70, height: 120)
                        //this must be called after changing any size or margin property of this class to get acurrate margin
                         self.hscroll.setItemsMarginOnce()
                        
                        self.intercactArray = usermodel.interacts! as NSArray;
                        
                        var k = -1;
                        
                        for inter in self.intercactArray {
                            k = k+1;
                            let model:userDeatailInteract = inter as! userDeatailInteract
                            let view1 = UIView(frame: CGRect.zero);
                            view1.tag = k;
                            let tap = UITapGestureRecognizer(target: self, action:  #selector(self.handleTap))
                        
                            view1.addGestureRecognizer(tap)
                            
                            let imageName1 = "set"
                            let image1 = UIImage(named: imageName1)
                           let imageView = UIImageView()
                            
                             imageView.contentMode = UIViewContentMode.scaleAspectFit
                            imageView.frame = CGRect(x: 0, y: 25, width: 70, height: 70)
                            imageView.image = image1
                            imageView.contentMode = UIViewContentMode.scaleAspectFit
                            imageView.clipsToBounds = true;
                           imageView.layer.cornerRadius = 35.0
                           imageView.backgroundColor = UIColor.white
                            imageView.isUserInteractionEnabled = true
                            view1.addSubview(imageView)
                            self.hscroll.addItem(view1)
                            
                            Alamofire.request(model.interactImage!).responseImage { response in
                                
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
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                         
                            
                            
                            
                            
                            
                           
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
//                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
                        
                        
                    }else{
                        
//                        self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: homrres.message!);
//                        JustHUD.shared.hide()
                        
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
    
    
    func createUI(){
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select Peep"
        
       
       

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        self.Fname.setBottomBorder(img: "man",placeholder:"First Name")
        self.Lname.setBottomBorder(img: "man",placeholder:"Last Name")
        self.getuserDetails()
        
    }
     @objc func buttonClicked1(sender:UIButton) {
//
        let vc = storyboard?.instantiateViewController(withIdentifier: "set") as! SettingsTableViewController
        
        let nav1 = UINavigationController()
        
        nav1.viewControllers = [vc]
        
        //                    self.navigationController?.pushViewController(vc,
        //                                                                  animated: true)
        //
        self.present(nav1, animated: true, completion: nil)
    }
    @objc func buttonClicked(sender:UIButton) {
        
          if(sender.tag == 0){
            let vc = storyboard?.instantiateViewController(withIdentifier: "mpeeps") as! MypeepsViewController
            self.present(vc, animated: true, completion: nil)
        }
        if(sender.tag == 1){
            let vc = storyboard?.instantiateViewController(withIdentifier: "ppeeps") as! peerPeepsViewController
            self.present(vc, animated: true, completion: nil)
        }
        if(sender.tag == 2){
            let vc = storyboard?.instantiateViewController(withIdentifier: "flow") as! Flow20TableViewController
            let nav1 = UINavigationController()
            
            nav1.viewControllers = [vc]
            self.present(nav1, animated: true, completion: nil)
        }
    
    }

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
