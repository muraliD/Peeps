//
//  ForgotViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 7/31/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit

@objc protocol SecondVCDelegate: class {
    @objc optional func changeQuote(_ evalue: String?)
    @objc optional func close()
    @objc optional func getpeeps(_ evalue: NSArray?,type:String?)
    @objc optional func getpegs(_ evalue: String?,type:String?)
}
class ForgotViewController: UIViewController {
weak var delegate: SecondVCDelegate?
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var enailTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        enailTxt.setBottomBorder(img: "email",placeholder:"Email")
        bgView.layer.borderColor = UIColor(red: 132.0/255.0, green: 96.0/255.0, blue: 169.0/255.0, alpha: 1.0).cgColor
        bgView.layer.shadowRadius = 5.0
        bgView.layer.borderWidth = 1.0


        // Do any additional setup after loading the view.
    }

    @IBAction func resetAction(_ sender: Any) {
        delegate?.changeQuote!(enailTxt.text)
    }
    @IBAction func closeAction(_ sender: Any) {
        delegate?.close!()
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
