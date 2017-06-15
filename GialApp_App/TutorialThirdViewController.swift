//
//  TutorialThirdViewController.swift
//  GialApp_App
//
//  Created by Andrew Amato on 04/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit


class TutorialThirdViewController: UIViewController {

    //MARK: outlet and properties
    @IBOutlet weak var allViewsSV: UIStackView!
    @IBOutlet weak var oView0: UIView!
    @IBOutlet weak var oView1: UIView!
    @IBOutlet weak var oView2: UIView!
    @IBOutlet weak var oView3: UIView!
    var origin0 = CGPoint()
    var width0 = CGFloat()
    var height0 = CGFloat()
    
    var center1 = CGPoint()
    var center2 = CGPoint()
    var center3 = CGPoint()
    
    var size0 = CGSize()
    var size1 = CGSize()
    var size2 = CGSize()
    var size3 = CGSize()

    
    
    override func viewDidLoad() {
        origin0 = oView0.frame.origin
        width0 = oView0.frame.width
        height0 = oView0.frame.height
        center1 = oView1.center
        center2 = oView2.center
        center3 = oView3.center
        size0 = oView0.frame.size
        size1 = oView1.frame.size
        size2 = oView2.frame.size
        size3 = oView3.frame.size
        
        super.viewDidLoad()
        let tapToEnlarge0 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge1 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge2 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge3 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))

        allViewsSV.arrangedSubviews[0].addGestureRecognizer(tapToEnlarge0)
        allViewsSV.arrangedSubviews[1].addGestureRecognizer(tapToEnlarge1)
        allViewsSV.arrangedSubviews[2].addGestureRecognizer(tapToEnlarge2)
//        allViewsSV.arrangedSubviews[3].addGestureRecognizer(tapToEnlarge3)
//        
//
//        oView0.addGestureRecognizer(tapToEnlarge0)
//        oView1.addGestureRecognizer(tapToEnlarge1)
//        oView2.addGestureRecognizer(tapToEnlarge2)
//        oView3.addGestureRecognizer(tapToEnlarge3)
//        
//        allViewsSV.arrangedSubviews[1].addGestureRecognizer(tapToEnlarge)
//        allViewsSV.arrangedSubviews[2].addGestureRecognizer(tapToEnlarge)
        
      
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}

extension TutorialThirdViewController {
    func tapToEnlargeFunction (gesture: UIGestureRecognizer) {
        
        self.allViewsSV.removeArrangedSubview(oView1)

        UIView.animate(withDuration: 0.4) {
            self.oView0.removeFromSuperview()
            
            self.allViewsSV.addArrangedSubview(self.oView0)
            self.oView1.frame.origin = self.origin0
            self.oView1.frame.size.width = self.width0
            self.oView1.frame.size.height = self.height0
            
            self.view.addSubview(self.oView1)
            
            print("\ncenter1: \(self.center1)")
            print("\ncenter2: \(self.center2)")
            print("\ncenter3: \(self.center3)")

        }
       
        print("inside the tap to enlarge function")
    }
    
}
