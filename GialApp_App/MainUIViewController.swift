//
//  MainUIViewController.swift
//  GialApp_App
//
//  Created by Andrew Amato on 22/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

class MainUIViewController: UIViewController {

    @IBOutlet weak var view0: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet var viewRuote: ViewRuoteUIView!
    @IBOutlet var viewGforce: ViewGforceUIView!
    @IBOutlet var viewAccelerazione: ViewAccelerazioneUIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view0.addSubview(viewRuote)
        view1.addSubview(viewGforce)
        viewGforce.frame.size.width = view1.frame.width
        viewGforce.frame.size.height = view1.frame.height
     
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
