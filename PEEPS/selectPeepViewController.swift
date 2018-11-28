//
//  selectPeepViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 10/14/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//
@objc protocol selDelegate: class {
  
    @objc optional func selectdata(_ evalue: NSMutableDictionary?)
   
}
class Cellp: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
     @IBOutlet weak var chkbtn: UIButton!
    
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
import UIKit
import Alamofire
private let reuseIdentifier = "Cell1"
class selectPeepViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,SecondVCDelegate {
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    func changeQuote(_ evalue: String?) {
        
    }
    weak var delegate: selDelegate?
    
    @IBAction func proceedAtion(_ sender: Any) {
    }
    @IBOutlet weak var procBtn: UIButton!
    func close() {
        self.getpeepsDetails();
    }
    func getpeeps(_ evalue: NSArray?) {
//        self.ResultsArray = evalue! as NSArray
//        self.countLbl.text = String(self.ResultsArray.count)+" "+"Peeps"
//        self.collectionView.reloadData()
    }
  

    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var ResultsArray:NSMutableArray = []

    var finResultsArray: NSMutableDictionary = [:]
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
    }
    func getpeepsDetails() {
        
//        self.countLbl.text = "No"+" "+"Peeps"
        
        
        
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
                        
                        
                        let array = homrres.responseData! as NSArray
                        
                        
                        
                        self.ResultsArray  =  NSMutableArray(array: array)
//                        self.countLbl.text = String(self.ResultsArray.count)+" "+"Peeps"
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
    @objc func addTapped(sender: AnyObject) {
        
        if(self.finResultsArray.count>0){
            var finalstring:String = ""
            
            let doneArray = self.finResultsArray.allKeys
            
            for item in doneArray {
                
                finalstring += item as! String + ","
                
                
            }
            
            delegate?.selectdata!(self.finResultsArray)
            self.navigationController?.dismiss(animated: true, completion: nil)
            
            
        }else{
            
                                      self.appDelegate?.showNetworkAlert(viewc: self,titles: "Peeps", messages: "Please select at least one item");
            
        }
        
        
        
    }
    @objc func onClcikBack(sender: AnyObject) {
       self.navigationController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title  = "Select Peep"
        


        
        
        let btnLeftMenu1: UIButton = UIButton()
        btnLeftMenu1.addTarget(self, action: #selector(self.addTapped), for: UIControlEvents.touchUpInside)
        btnLeftMenu1.setTitle("Done", for: .normal)
        btnLeftMenu1.setTitleColor(UIColor.white, for: .normal)
        btnLeftMenu1.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton1 = UIBarButtonItem(customView: btnLeftMenu1)
        self.navigationItem.rightBarButtonItem = barButton1
        
        
        //Back buttion
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "la-29"), for: UIControlState())
        btnLeftMenu.addTarget(self, action: #selector(self.onClcikBack), for: UIControlEvents.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        
        
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView?.register(UINib(nibName: "collectioncelltick", bundle: nil), forCellWithReuseIdentifier: "collectioncell")
        self.collectionView!.backgroundView = UIImageView(image: UIImage(named: "background"))
        self.collectionView?.delegate=self
        self.collectionView?.dataSource=self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.itemSize = CGSize(width: self.view.frame.size.width/2, height: self.view.frame.size.width/2-8)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionView!.collectionViewLayout = layout
        
        
      
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
        
        
        
     
        
        self.getpeepsDetails();
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! Cellp
        
        
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
        
           cell.chkbtn.addTarget(self, action:#selector(self.checkAction), for: .touchUpInside)
        
        
        
        cell.chkbtn.tag = indexPath.row
        if(usermodel.ischeck == true){
           cell.chkbtn.setImage(UIImage(named: "check"), for: .normal)
        }else{
             cell.chkbtn.setImage(UIImage(named: "uncheck"), for: .normal)
        }
        
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
    @objc func checkAction(sender:UIButton) {
        var usermodel:peepsModelResponseData = self.ResultsArray [sender.tag] as! peepsModelResponseData
        
        
        if(sender.imageView?.image == UIImage(named: "check")){
            usermodel.ischeck = false
            finResultsArray.removeObject(forKey: usermodel.id!)
            
        }else{
            
            usermodel.ischeck = true
           finResultsArray[usermodel.id!] = usermodel
            
            
        }
        self.ResultsArray[sender.tag] = usermodel
        self.collectionView.reloadData();
        
       
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2+30)
    }
    func  collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      
        let usermodel:peepsModelResponseData = self.ResultsArray [indexPath.row] as! peepsModelResponseData
//      usermodel.id
        
     
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
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
