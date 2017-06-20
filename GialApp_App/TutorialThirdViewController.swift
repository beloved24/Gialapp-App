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
    
    //MARK: outlet della view 0
    @IBOutlet weak var oView0: UIView!
    @IBOutlet weak var firstSubviewView0: UIImageView!
    @IBOutlet weak var oGradiRuotaAvSx: UILabel!
    @IBOutlet weak var oGradiRuotaAvDx: UILabel!
    @IBOutlet weak var oGradiRuotaDieSx: UILabel!
    @IBOutlet weak var oGradiRuotaDieDx: UILabel!
    
    //MARK: outlet della view 1
    @IBOutlet weak var oView1: UIView!
   
    @IBOutlet weak var oView2: UIView!
    
    @IBOutlet weak var oView3: UIView!
    
    @IBOutlet weak var containterView: UIView!
    
    let lineaSeparatrice = UIImageView()
    
    
    var frame123 = CGRect()
    var frame0 = CGRect()
    var center0 = CGPoint()
    var center1 = CGPoint()
    var center2 = CGPoint()
    var center3 = CGPoint()
    let durationOfAnimation = 0.3
    var frameThumbFirstSubviewView0 = CGRect()
    
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
        if let _  = movingView.subviews.first {
            movingView.subviews.first!.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                movingView.center = self.center0
                movingView.frame = self.frame0
                
            }, completion: {
                if $0 {
                    UIView.animate(withDuration: 0.25, animations: { 
                        movingView.subviews.first?.frame = self.frameThumbFirstSubviewView0
                        movingView.subviews.first!.alpha = 1
                        movingView.tag = 99
                        movingView.subviews[1].alpha = 1
                    })
                }
            })
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                movingView.center = self.center0
                movingView.frame = self.frame0
            }, completion: {
                if $0 {
                    movingView.tag = 99
                }
            })
        }
        movingView.isUserInteractionEnabled = false
    
    }
    
    func movingBackFunction (movingView: UIView, at destinationCenter: CGPoint, with destinationFrame: CGRect){
        movingView.isUserInteractionEnabled = true

        if let _ = movingView.subviews.first {
            movingView.subviews.first!.alpha = 0
            movingView.subviews[1].alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.frameThumbFirstSubviewView0 = (movingView.subviews.first?.frame)!
                movingView.center = destinationCenter
                movingView.frame = destinationFrame
                
                
                
            }, completion: {
                if $0 {
                    UIView.animate(withDuration: 0.25, animations: { 
                        movingView.subviews.first!.frame = movingView.bounds
                        movingView.subviews.first?.contentMode = .scaleAspectFit
                        movingView.subviews.first!.alpha = 1
                    })
                    movingView.tag = 500
                    
                    print(movingView.frame)
                    print(movingView.subviews.first!.frame)
                }
            })
        }
        else {
                UIView.animate(withDuration: 0.5, animations: {
                movingView.center = destinationCenter
                movingView.frame = destinationFrame
            }, completion: {
                if $0 {
                    movingView.tag = 500
                }
            })
        }
        
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
        
        oView0.layer.cornerRadius = 10.0
        oView0.layer.borderColor = view.backgroundColor?.cgColor
        oView0.layer.borderWidth = 2
        oView0.isUserInteractionEnabled = false
        
        oView1.layer.cornerRadius = 15.0
        oView1.layer.borderWidth = 1.0
        oView1.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        
        oView2.layer.cornerRadius = 15.0
        oView2.layer.borderWidth = 1.0
        oView2.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        
        oView3.layer.cornerRadius = 15.0
        oView3.layer.borderWidth = 1.0
        oView3.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        
        
        
        
        //MARK: setting degli elementi della view 0
        
    
        
        //-------------- elemento principale
        
        firstSubviewView0.frame.size.width = self.view.frame.width/2.5
        firstSubviewView0.frame.size.height = self.view.frame.height/2.5
        firstSubviewView0.center.x = self.view.center.x
        firstSubviewView0.center.y = self.oView0.center.y - firstSubviewView0.frame.height/5
        
        frameThumbFirstSubviewView0 = firstSubviewView0.frame
        
        //-------------- labels
        
        oGradiRuotaAvSx.frame.size.width = firstSubviewView0.frame.width - 5
        oGradiRuotaAvSx.frame.size.height = firstSubviewView0.frame.height/5
        oGradiRuotaAvSx.contentMode = .bottomRight
        oGradiRuotaAvSx.frame.origin.x = firstSubviewView0.frame.origin.x - oGradiRuotaAvSx.frame.width - 5
        oGradiRuotaAvSx.frame.origin.y = firstSubviewView0.frame.origin.y
        oGradiRuotaAvSx.text = "0.0°"
        oGradiRuotaAvSx.adjustsFontSizeToFitWidth = true
        //oGradiRuotaAvSx.backgroundColor = UIColor.red
        
        
        oGradiRuotaAvDx.frame.size.width = oGradiRuotaAvSx.frame.width
        oGradiRuotaAvDx.frame.size.height = oGradiRuotaAvSx.frame.height
        //oGradiRuotaAvDx.contentMode = .bottomRight
        oGradiRuotaAvDx.frame.origin.x = firstSubviewView0.frame.origin.x + firstSubviewView0.frame.width
        oGradiRuotaAvDx.frame.origin.y = firstSubviewView0.frame.origin.y
        oGradiRuotaAvDx.text = "0.0°"
        oGradiRuotaAvDx.adjustsFontSizeToFitWidth = true
        //oGradiRuotaAvDx.backgroundColor = UIColor.red
        
        oGradiRuotaDieSx.frame.size.width = oGradiRuotaAvSx.frame.width
        oGradiRuotaDieSx.frame.size.height = oGradiRuotaAvSx.frame.height
        oGradiRuotaDieSx.frame.origin.x = oGradiRuotaAvSx.frame.origin.x
        oGradiRuotaDieSx.frame.origin.y = firstSubviewView0.frame.origin.y + firstSubviewView0.frame.height - oGradiRuotaDieSx.frame.height
        oGradiRuotaDieSx.text = "0.0°"
        //oGradiRuotaDieSx.backgroundColor = UIColor.red
        
        oGradiRuotaDieDx.frame.size.width = oGradiRuotaAvSx.frame.width
        oGradiRuotaDieDx.frame.size.height = oGradiRuotaAvDx.frame.height
        oGradiRuotaDieDx.frame.origin.x = oGradiRuotaAvDx.frame.origin.x
        oGradiRuotaDieDx.frame.origin.y = oGradiRuotaDieSx.frame.origin.y
        oGradiRuotaDieDx.text = "0.0°"
        //oGradiRuotaDieDx.backgroundColor = UIColor.red
        
        //----------------- linea di separazione 
        
        lineaSeparatrice.image = UIImage(named: "lineaSeparazione")
        lineaSeparatrice.center.x = firstSubviewView0.center.x
        lineaSeparatrice.center.y = firstSubviewView0.center.y + firstSubviewView0.frame.height/2 + 10
        lineaSeparatrice.backgroundColor = UIColor.red
        oView0.addSubview(lineaSeparatrice)
        
     
    }
    
   
    
}
