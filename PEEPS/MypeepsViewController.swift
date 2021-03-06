//
//  MypeepsViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 8/4/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

extension UIImageView {
    
    func setRounded(borderWidth: CGFloat = 0.0, borderColor: UIColor = UIColor.clear) {
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        layer.borderWidth = borderWidth
    
        
       
    }
}
import UIKit
import Alamofire
import AlamofireImage
private let reuseIdentifier = "Cell"



class Cell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
     @IBOutlet weak var label: UILabel!
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.setRounded()
        
    }
    
    func setCircularImageView() {
        self.imageView.layer.cornerRadius = CGFloat(roundf(Float(self.imageView.frame.size.width / 2.0)))
    }
}


class MypeepsViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,SecondVCDelegate {
    func changeQuote(_ evalue: String?) {
        
    }
    
    @IBAction func proceedAtion(_ sender: Any) {
    }
    @IBOutlet weak var procBtn: UIButton!
    func close() {
        self.getpeepsDetails();
    }
    func getpeeps(_ evalue: NSArray?, type: String?) {
        if(type == "S"){
            
            self.types = "S"
            self.ResultsArray = evalue! as NSArray
            self.countLbl.text = String(self.ResultsArray.count)+" "+"Peeps"
            self.collectionView.reloadData()
        }else{
            self.getpeepsDetails()
            self.types = ""
            
        }
       
    }
    
let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var topImgView: UIImageView!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var ResultsArray:NSArray = []
      var types:String!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        if(self.types
            != "S"){
          self.getpeepsDetails()
           
        }
        
    }
    func getpeepsDetails() {
        
        self.countLbl.text = "No"+" "+"Peeps"
        
        
        
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
        
        
        
        
        
        Alamofire.request(APPURL.peepsApi, method: .post, parameters: parameters as [String: Any], encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success:
                JustHUD.shared.hide()
                
                
                
                do {
                    let homrres:peepsModelRootClass = try JSONDecoder().decode(peepsModelRootClass.self, from: response.data!)
                    
                    if(homrres.success)!{
                        
                        
                        self.ResultsArray = homrres.responseData! as NSArray
                        self.countLbl.text = String(self.ResultsArray.count)+" "+"Peeps"
                        self.collectionView.reloadData()
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
        
      
        
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView?.register(UINib(nibName: "collectioncell", bundle: nil), forCellWithReuseIdentifier: "collectioncell")
        self.collectionView!.backgroundView = UIImageView(image: UIImage(named: "background"))
        self.collectionView?.delegate=self
        self.collectionView?.dataSource=self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.itemSize = CGSize(width: self.view.frame.size.width/2, height: self.view.frame.size.width/2-8)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionView!.collectionViewLayout = layout
        
        
        topImgView.isUserInteractionEnabled = true
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
        
        
        
        var xf = 0;
        
        let inputArray = [["name":"MyPeeps","img":"la"],["name":"PeerPeers","img":"flow"],["name":"Flow20","img":"sear"],["name":"Flow20","img":"au"]];
        
        
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
        
        self.getpeepsDetails();
    }
    @objc func buttonClicked(sender:UIButton) {
            
            if(sender.tag == 0){
                self.dismiss(animated: true, completion: nil)
            }
        if(sender.tag == 1){
            let vc = storyboard?.instantiateViewController(withIdentifier: "flow") as! Flow20TableViewController
            let nav1 = UINavigationController()
            
            nav1.viewControllers = [vc]
            self.present(nav1, animated: true, completion: nil)
        }
        if(sender.tag == 3){
            let vc = storyboard?.instantiateViewController(withIdentifier: "adpe") as! AddPeepTableViewController
           vc.delegate = self;
            let nav1 = UINavigationController()
            
            nav1.viewControllers = [vc]
            
            //                    self.navigationController?.pushViewController(vc,
            //                                                                  animated: true)
            //
            self.present(nav1, animated: true, completion: nil)
        }
        if(sender.tag == 2){
            let vc = storyboard?.instantiateViewController(withIdentifier: "psearch") as! PeepSearchTablvController
            vc.delegate = self;
            let nav1 = UINavigationController()
            
            nav1.viewControllers = [vc]
            
            //                    self.navigationController?.pushViewController(vc,
            //                                                                  animated: true)
            //
            self.present(nav1, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.ResultsArray.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        ///let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath)
        
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! Cell
        
        
//        let prodImg:UIImageView=(cell.viewWithTag(934) as? UIImageView)!
        
        
//        prodImg.setRounded();
        
//        prodImg.layer.borderWidth = 1
//        prodImg.layer.masksToBounds = false
//        prodImg.layer.borderColor = UIColor.white.cgColor
//        prodImg.layer.cornerRadius = prodImg.frame.height/2
//        prodImg.clipsToBounds = true
//
        
        
//        cell.label.text =
        
//        let  plabel:UILabel=(cell.viewWithTag(935) as? UILabel)!
//        let Spinner:UIActivityIndicatorView=(cell.viewWithTag(936) as? UIActivityIndicatorView)!
        
        
      
                            let usermodel:peepsModelResponseData = self.ResultsArray [indexPath.row] as! peepsModelResponseData
        
        
        
        
//        let prodData:prodData = self.productsArray[indexPath.row] as! prodData
        cell.label.text = usermodel.firstName!+"  "+usermodel.lastName!
//        Spinner.isHidden = false
//
        Alamofire.request(usermodel.profilePic!).responseImage { response in

            if let imagess = response.result.value {
//                Spinner.isHidden = true
//                Spinner.stopAnimating()
               cell.imageView.image = imagess

            }else{

//                Spinner.isHidden = true
//                Spinner.stopAnimating()
                //                imageview.image = UIImage(named: "avatar")


            }

        
            
            
            
      }
        
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2+30)
    }
     func  collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "pdet") as! PeepDetailViewController
        let usermodel:peepsModelResponseData = self.ResultsArray [indexPath.row] as! peepsModelResponseData
        vc.peepid = usermodel.id
        vc.peepname = usermodel.firstName!+" "+usermodel.lastName!
        
        let nav1 = UINavigationController()
    
        nav1.viewControllers = [vc]
        
//                    self.navigationController?.pushViewController(vc,
//                                                                  animated: true)
//
        self.present(nav1, animated: true, completion: nil)
        
        
        
        
        
//
//
//        let vc = storyboard?.instantiateViewController(withIdentifier: "pd") as!ProductDeailViewController
//
//
//        let prodData:prodData = self.productsArray[indexPath.row] as! prodData
//        vc.prodData = prodData
//        self.navigationController?.pushViewController(vc,
//                                                      animated: true)
        
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:self.collectionView.frame.size.width, height:59.0)
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
