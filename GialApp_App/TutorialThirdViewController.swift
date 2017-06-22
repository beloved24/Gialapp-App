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
    @IBOutlet weak var oView0: MyCustomUIView!
    
    //MARK: outlet della view 1
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
    var frameGRANDEfirstSubviewView0 = CGRect()
    var frameContainersViewGrandi = CGRect()
    
    var view1AlreadySetted : Bool = false
    
    
    //MARK: elementi contenuti nelle altre view
    
    //---------------- view 1
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForSwitchingViews()
       // settingsForAnimation()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    /*
    func settingsForAnimation() {
        axis.center.x = firstSubviewView0.center.x - 3
        assettoImage.center.x = axis.center.x
        axis.center.y = firstSubviewView0.center.y - 30
        assettoImage.frame.origin.y = axis.center.y + 16

        assettoImage.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        let angle = Float.pi/2
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.assettoImage.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        })
    }*/

  
}

extension TutorialThirdViewController {
    
    func tapToEnlargeFunction (gesture: UIGestureRecognizer) {
        //la view che sta al centro è sempre la view con tag 0
        let destinationFrame = gesture.view!.frame
        let destinationCenter = gesture.view?.center
        
        movingBackFunction(movingView: self.view.viewWithTag(99)! as! MyCustomUIView, at: destinationCenter!, with: destinationFrame)
        movingViewAtCenter(movingView: gesture.view! as! MyCustomUIView)
        
    }
    
    func movingViewAtCenter (movingView: MyCustomUIView) {
        
        if let _  = movingView.subviews.first {
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
    
    func "..."{
        //la moving view quì è quella che sta al centro e che deve spostarsi in basso
        movingView.isUserInteractionEnabled = true
        
        if let _ = movingView.subviews.first {
            
            
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                movingView.subviews[1].alpha = 0 //questo è per oscurare tutte le cose che non servono quando la view è piccola
                movingView.frame.size.width /= 2
                movingView.frame.size.height /= 2
                movingView.center.x *= 2
                movingView.center.y *= 2
                
                movingView.subviews.first?.frame.size.width = destinationFrame.width*0.9
                movingView.subviews.first?.frame.size.height = destinationFrame.height*0.9
                movingView.subviews.first?.center.x = movingView.frame.width/2
                movingView.subviews.first?.center.y = movingView.frame.height/2
                

            }, completion: {
                if $0 {
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: { 
                        movingView.center = destinationCenter
                        movingView.frame = destinationFrame
                        //DEVI SETTARE IL FRAME DEL CONTAINER VIEW 
                        
                        movingView.subviews[1].frame = movingView.bounds
                        movingView.subviews.first!.frame = movingView.bounds
                        movingView.subviews.first?.frame.size.width = movingView.bounds.width*0.9
                        movingView.subviews.first?.frame.size.height = movingView.bounds.height*0.9
                        //queste ultime tre righe ti mettno la macchinina o chi per essa al posto giusto e la ridimensionano come la vogliamo noi
                        movingView.subviews.first?.center.x = movingView.frame.width/2
                        movingView.subviews.first?.center.y = movingView.frame.height/2
                        //queste ultime due invece la mettono al centro
                        
                        
                        movingView.subviews.first?.contentMode = UIViewContentMode.scaleAspectFit
                    }, completion: {
                        if $0 {
                            movingView.tag = 500
                        }
                    })
                }
            })
        }
        else {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                
                movingView.frame.size.width /= 2
                movingView.frame.size.height /= 2
                movingView.center.x *= 2
                movingView.center.y *= 2
                
            }, completion: {
                if $0 {
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: { 
                        movingView.center = destinationCenter
                        movingView.frame = destinationFrame
                        //movingView.subviews.first!.frame = movingView.bounds
                        //movingView.subviews.first?.contentMode = .scaleAspectFit
                    }, completion: {
                        if $0 {
                            movingView.tag = 500
                        }
                    })
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
        oView0.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        oView0.layer.borderWidth = 1.0
        oView0.isUserInteractionEnabled = false
        
        oView1.layer.cornerRadius = 10.0
        oView1.layer.borderWidth = 1.0
        oView1.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        
        oView2.layer.cornerRadius = 10.0
        oView2.layer.borderWidth = 1.0
        oView2.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        
        oView3.layer.cornerRadius = 10.0
        oView3.layer.borderWidth = 1.0
        oView3.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        
        oView0.identificativoView = 0
//        oView1.identificativoView = 1
//        oView2.identificativoView = 2
//        oView3.identificativoView = 3
        
        
        //MARK: setting degli elementi della view 0
        
    
        
        //-------------- elemento principale
        
        
        //-------------- labels
        
               //oGradiRuotaAvSx.backgroundColor = UIColor.red
        
        
    
       
        settingsDelleAltreView()
        
    }
    
    func settingsDelleAltreView() {
        //MARK: impostazioni iniziali della VIEW1
        //adesso mi aggiungo alla view uno tutte le cose che questa contiene
        
    }
    
    
    func setView(movingView: MyCustomUIView) {
        switch movingView.identificativoView {
        case 1:
            print("sto settando il contenuto della view uno che si è appena spostata al centro")
            
            //per prima cosa inizio a settare le dimensioni del container
          
            
            break
            
        default:
            //fdkj ddfjfdf  g o gsos o sgos ois o i
            break
            
        }
    }
    
   
    
}
