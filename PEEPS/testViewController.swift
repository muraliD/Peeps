//
//  testViewController.swift
//  PEEPS
//
//  Created by Murali Dadi on 10/22/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import Dkit_Dragdrop

class testViewController: UIViewController,DKDraggableViewDelegate {
    @IBOutlet weak var drag: DKDraggableView!
    
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drag.delegate = self
        drag.enableDragging = true
        drag.setDropTarget(target: img)
        
        
    }
    
    func onDropedToTarget(sender: DKDraggableView, target:UIView) {
        NSLog("Drop to target \(target.tag)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
