//
//  MainUIViewController.swift
//  GialApp_App
//
//  Created by Andrew Amato on 22/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit
import CoreMotion

class MainUIViewController: UIViewController {

    @IBOutlet weak var view0: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet var viewRuote: ViewRuoteUIView!
    @IBOutlet var viewGforce: ViewGforceUIView!
    @IBOutlet var viewAccelerazione: ViewAccelerazioneUIView!
    
    let motionManager = CMMotionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view0.addSubview(viewRuote)
        view1.addSubview(viewGforce)
        viewGforce.frame.size.width = view1.frame.width
        viewGforce.frame.size.height = view1.frame.height
        
        let tapToEnlarge0 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge1 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge2 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge3 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        
        view0.addGestureRecognizer(tapToEnlarge0)
        view1.addGestureRecognizer(tapToEnlarge1)
        view2.addGestureRecognizer(tapToEnlarge2)
        view3.addGestureRecognizer(tapToEnlarge3)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}


extension MainUIViewController {
    
    func tapToEnlargeFunction (gesture: UIGestureRecognizer) {
        //la view che sta al centro è sempre la view con tag 0
        let destinationFrame = gesture.view!.frame
        let destinationCenter = gesture.view?.center
        
        //movingBackFunction(movingView: self.view.viewWithTag(99)! as! MyCustomUIView, at: destinationCenter!, with: destinationFrame)
        movingViewAtCenter(movingView: gesture.view! as! MyCustomUIView)
        
    }
    
    func movingViewAtCenter (movingView: UIView) {
        if (movingView.subviews.first!.isKind(of: ViewRuoteUIView.self)) {
            let gestureView = movingView.subviews.first as! ViewRuoteUIView
            //questa gesture view è quella da allargare
        }
        else if (movingView.subviews.first!.isKind(of: ViewAccelerazioneUIView.self)) {
            let gestureView = movingView.subviews.first as! ViewAccelerazioneUIView
        }
        else if  (movingView.subviews.first!.isKind(of: ViewGforceUIView.self)) {
            let gestureView = movingView.subviews.first as! ViewGforceUIView
        }
        
    }
    
       /* if let _  = movingView.subviews.first {
            //quì gestisco la cafonata
            //movingView.subviews.first!.alpha = 0
            // quella che contiente tutte le cose che non servono quando è piccola adesso deve tornare ad essere visibile
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                let center = movingView.center
                movingView.frame.size.width *= 2
                movingView.frame.size.height *= 2
                movingView.center = center
                movingView.subviews.first?.frame.size.width *= 2
                movingView.subviews.first?.frame.size.height *= 2
            }, completion: {
                if $0 {
                    //quì gestisco lo spostamento vero e proprio
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                        movingView.center = self.center0
                        movingView.frame = self.frame0
                        movingView.subviews.first?.frame = self.frameGRANDEfirstSubviewView0
                        self.setView(movingView: movingView)
                        movingView.subviews[1].alpha = 1 //rendo il containre visibile dopo che l'ho settato in moveview
                        
                    }, completion: {
                        if $0 {
                            movingView.tag = 99
                        }
                    })
                    
                }
            })
        }
            
        else {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                let center = movingView.center
                movingView.frame.size.width *= 2
                movingView.frame.size.height *= 2
                movingView.center = center
                
            }, completion: {
                if $0 {
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                        movingView.center = self.center0
                        movingView.frame = self.frame0
                        
                        //movingView.subviews.first?.frame = self.frameGRANDEfirstSubviewView0
                        //movingView.subviews[1].alpha = 1
                    }, completion: {
                        if $0 {
                            movingView.tag = 99
                        }
                    })
                }
            })
        }
        movingView.isUserInteractionEnabled = false
        
    }
    
    
    
   
     func tapToEnlargeFunction (gesture: UIGestureRecognizer)  {
        
        
        if (gesture.view?.subviews.first!.isKind(of: ViewRuoteUIView.self))! {
            let gestureView = gesture.view?.subviews.first as! ViewRuoteUIView
            //questa gesture view è quella da allargare
            
            
        }
        else if (gesture.view?.subviews.first!.isKind(of: ViewAccelerazioneUIView.self))! {
            
        }
        else if  (gesture.view?.subviews.first!.isKind(of: ViewGforceUIView.self))! {
            
        }
     */
}






