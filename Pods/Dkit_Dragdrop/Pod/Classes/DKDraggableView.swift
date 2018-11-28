
import UIKit

public protocol DKDraggableViewDelegate{
    func onDropedToTarget(sender: DKDraggableView, target: UIView)
}

public class DKDraggableView: UIImageView, UIGestureRecognizerDelegate {
    
    private var enableDragMovement = false
    private var draggingView :DKDraggableView?
    private var dropTarget : UIView?
    private var dropTargetIsEnlarge = false
    private var isLeavingAfterEnteredDropTarget = false
    private var isEnteredDropTarget = false

    public var delegate:DKDraggableViewDelegate?
    public var enableDragging = true {
        didSet{
            if enableDragging == true {
                self.isUserInteractionEnabled = true
                
                let longPressGesture = UILongPressGestureRecognizer(target: self, action:  #selector(self.responseToLongPressGesture))
                longPressGesture.delegate = self
                self.addGestureRecognizer(longPressGesture)
                
                let panGesture = UIPanGestureRecognizer(target: self, action:  #selector(self.responseToPanGesture))
                self.addGestureRecognizer(panGesture)
                
            }else if(enableDragging == false){
                self.gestureRecognizers = []
            }
        }
    }
    
    
    
    //MAKR: make fake dragging View
    private func createFakeDragginView() {
        
        draggingView = DKDraggableView(frame: self.frame)
        draggingView?.isUserInteractionEnabled = true
        draggingView?.autoresizingMask = []
        draggingView?.contentMode = UIViewContentMode.center
        draggingView?.layer.cornerRadius = 5.0
        draggingView?.layer.borderWidth = 1.0
        draggingView?.clipsToBounds = true
        
        draggingView?.addSubview(UIImageView(image: scaledImageToSize(image: self.image!, newSize: self.bounds.size)))
        
        self.superview?.addSubview(draggingView!)
        
    }
    
    private func removeFakeDraggingView(){
        draggingView?.removeFromSuperview()
    }
    
    //MARK: touch handling
    @objc func responseToLongPressGesture(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizerState.began {
           
            enableDragMovement = true
            createFakeDragginView()
            animateView(view: draggingView!, sender: sender, scale: 1.3, alpha: 0.6, duration: 0.3)
        }
        else if sender.state == UIGestureRecognizerState.ended{
            
            enableDragMovement = false
            removeFakeDraggingView()
            animateView(view: draggingView!, sender: sender, scale: 1.0, alpha: 1.0, duration: 0.3)
            if dropTarget != nil{
                animateView(view: dropTarget!, sender: sender, scale: 1.0, alpha: 1.0, duration: 0.3)
                if isEnteredDropTarget{
                    delegate?.onDropedToTarget(sender: draggingView!,target: dropTarget!)
                }
            }
        }
    }
    
    
    @objc func responseToPanGesture(sender: UIPanGestureRecognizer){
        if enableDragMovement{
            if sender.state == UIGestureRecognizerState.began ||
                sender.state == UIGestureRecognizerState.changed {
                    
                let translation = sender.translation(in: draggingView!.superview!)
                
                
                    draggingView!.center = CGPoint(x: draggingView!.center.x + translation.x,y :draggingView!.center.y + translation.y)
                sender.setTranslation(CGPoint(x: 0,y :0), in: draggingView!.superview)
                
                    if dropTarget != nil{
                        checkIfEnterDropTarget(sender: sender)
                        checkIfLeavingDropTarget(sender: sender)
                        
                    }
            }
            if sender.state == UIGestureRecognizerState.ended{
                
                
            }
        }
    }    
    
    //MARK: drop target
    public func setDropTarget(target: UIView){
        dropTarget = target
    }
    
    private func checkIfEnterDropTarget(sender:UIGestureRecognizer) -> Bool{
        let location = sender.location(in: draggingView!.superview)
        if dropTarget!.frame.contains(location)
        {
            animateView(view: dropTarget!, sender: sender, scale: 1.5, alpha: 0.6, duration: 0.3)
            isEnteredDropTarget = true
        }
        else{
            if isEnteredDropTarget{
                isLeavingAfterEnteredDropTarget = true
            }
        }
        return isEnteredDropTarget
    }
    
    private func checkIfLeavingDropTarget(sender:UIGestureRecognizer){
        if isEnteredDropTarget && isLeavingAfterEnteredDropTarget{
            animateView(view: dropTarget!, sender: sender, scale: 1.0, alpha: 1.0, duration: 0.3)
            isEnteredDropTarget = false
            isLeavingAfterEnteredDropTarget = false
        }
        
    }
    
    //MARK: animation
    
    private func animateView(view:UIView, sender: UIGestureRecognizer, scale:CGFloat = 1.3, alpha:CGFloat = 0.5,duration:TimeInterval = 0.2){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        view.transform = CGAffineTransform(scaleX: scale, y: scale)
        view.alpha = alpha
        UIView.commitAnimations()
        
    }
    
    //MARK: delegate
    @objc public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    private func scaledImageToSize(image: UIImage, newSize: CGSize) -> UIImage{
        UIGraphicsBeginImageContext(newSize)
        
        
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}
