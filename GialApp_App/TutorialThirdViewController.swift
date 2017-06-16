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
   
    @IBOutlet weak var oView0: UIView!
    @IBOutlet weak var oView1: UIView!
    @IBOutlet weak var oView2: UIView!
    @IBOutlet weak var oView3: UIView!
    
    var frame123 = CGRect()
    var frame0 = CGRect()
    var center0 = CGPoint()
    var center1 = CGPoint()
    var center2 = CGPoint()
    var center3 = CGPoint()
    let durationOfAnimation = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForSwitchingViews()
  
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
        //la view che sta al centro è sempre la view con tag 0
        let destinationFrame = gesture.view!.frame
        let destinationCenter = gesture.view?.center
        
        movingBackFunction(movingView: self.view.viewWithTag(99)!, at: destinationCenter!, with: destinationFrame)
        movingViewAtCenter(movingView: gesture.view!)
        
    }
    
    func movingViewAtCenter (movingView: UIView) {
        print("inside the tp to enlarge function")
        let movingAnimation = CABasicAnimation(keyPath: "position")
        movingAnimation.fromValue = movingView.center
        movingAnimation.toValue = center0
        movingAnimation.duration = durationOfAnimation
        movingAnimation.beginTime = 0
        movingView.layer.add(movingAnimation, forKey: nil)
        movingView.layer.position = center0
        movingView.layer.cornerRadius = 10
        movingView.layer.borderWidth = 2
        movingView.layer.borderColor = self.view.backgroundColor?.cgColor
        //quà mi setto la dimensione della view in modo da portarla
        UIView.animate(withDuration: durationOfAnimation, animations: {
            movingView.frame = self.frame0
        })
        movingView.tag = 99
    }
    
    func movingBackFunction (movingView: UIView, at destinationCenter: CGPoint, with destinationFrame: CGRect){
        let movingAnimation = CABasicAnimation(keyPath: "position")
        movingAnimation.fromValue = movingView.center
        movingAnimation.toValue = destinationCenter
        movingAnimation.duration = durationOfAnimation
        movingAnimation.beginTime = 0
        movingView.layer.add(movingAnimation, forKey: nil)
        movingView.layer.position = destinationCenter
        movingView.layer.cornerRadius = 15.0
        movingView.layer.borderWidth = 4.0
        movingView.layer.borderColor = self.view.backgroundColor?.cgColor
        //quà mi setto la dimensione della view in modo da portarla
        UIView.animate(withDuration: durationOfAnimation, animations: {
            movingView.frame = destinationFrame
            
        })
        movingView.tag = 500
        
    }

    
    func settingsForSwitchingViews () {
        frame0 = oView0.frame
        frame123 = oView1.frame
        center0 = oView0.center
        center1 = oView1.center
        center2 = oView2.center
        center3 = oView3.center
        
        let tapToEnlarge0 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge1 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge2 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge3 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        
        oView0.addGestureRecognizer(tapToEnlarge0)
        oView1.addGestureRecognizer(tapToEnlarge1)
        oView2.addGestureRecognizer(tapToEnlarge2)
        oView3.addGestureRecognizer(tapToEnlarge3)
        
        oView0.layer.cornerRadius = 10
        oView0.layer.borderColor = self.view.backgroundColor?.cgColor
        oView0.layer.borderWidth = 2
        
        oView1.layer.cornerRadius = 15.0
        oView1.layer.borderWidth = 4.0
        oView1.layer.borderColor = self.view.backgroundColor?.cgColor
        
        oView2.layer.cornerRadius = 15.0
        oView2.layer.borderWidth = 4.0
        oView2.layer.borderColor = self.view.backgroundColor?.cgColor
        
        oView3.layer.cornerRadius = 15.0
        oView3.layer.borderWidth = 4.0
        oView3.layer.borderColor = self.view.backgroundColor?.cgColor
        
        
    }
    
   
    
}
