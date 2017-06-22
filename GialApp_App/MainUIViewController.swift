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
//        view0.addSubview(viewRuote)

        view0.addSubview(viewGforce)
        view3.addSubview(viewAccelerazione)
        
        
        //viewAccelerazione.frame.size.width = view0
        
        motionManager.accelerometerUpdateInterval = 0.1

        motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
            
            self.viewGforce.animazione(x: (data?.gravity.x)!, y: (data?.gravity.y)!, z: (data?.gravity.z)!)
        }
        


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
