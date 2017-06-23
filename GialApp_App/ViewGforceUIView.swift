//
//  ViewGforceUIView.swift
//  GialApp_App
//
//  Created by Andrew Amato on 22/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

extension Double {
    func arrotonda()->Double {
        return (self*100).rounded()/100
    }
}


class Frecce: UIView {
    
    var leFrecce: [UIImageView] = []
    
    let durata: TimeInterval = 2
    
    init(frame: CGRect, numeroDiFrecce: Int) {
        
        super.init(frame: frame)
        
        for i in 0..<numeroDiFrecce {
            let frecciaccia: UIImageView = UIImageView(image: #imageLiteral(resourceName: "frecciaGiu"))
            leFrecce.append(frecciaccia)
            leFrecce[i].contentMode = .scaleToFill
            leFrecce[i].frame.origin = .zero
            leFrecce[i].frame.size.width = self.frame.width
            leFrecce[i].frame.size.height = self.frame.height*2/CGFloat(numeroDiFrecce)
            leFrecce[i].alpha = 0
            
            self.addSubview(leFrecce[i])
            
            let delay: TimeInterval = durata*Double(i)/Double(numeroDiFrecce)
        
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                
                
            UIView.animateKeyframes(withDuration: self.durata, delay: delay, options: [.repeat, .beginFromCurrentState], animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    self.leFrecce[i].alpha = 1
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    self.leFrecce[i].alpha = 0
                })
                
                self.leFrecce[i].frame.origin.y = frame.height - self.leFrecce[i].frame.height
                
            }, completion:  nil)
        })
        }
        self.clipsToBounds = true
        
        //        self.layer.borderWidth = 2
        //        self.layer.borderColor = UIColor.red.cgColor
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class ViewGforceUIView: UIView {
    
    var frame0 = CGRect()
    var inMiniatura: Bool = true
    let defaultSize: CGSize = CGSize(width: 100, height: 100)

    let frecce = Frecce(frame: CGRect(x: 0, y: 0, width: 360, height: 420), numeroDiFrecce: 6)
    
    @IBOutlet weak var lineaOrizzontale: UIImageView!
    @IBOutlet weak var lineaVerticale: UIImageView!
    @IBOutlet weak var pallino: UIImageView!
    @IBOutlet weak var macchina: UIImageView!
    @IBOutlet weak var gTesto: UILabel!
    @IBOutlet weak var gNumero: UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.addSubview(frecce)
        frecce.center = (superview?.center)!
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.addSubview(frecce)

        frecce.center = self.center
        
    }
    
    func aggiornaLabel(numero: Double) {
        gNumero.text = String(numero.arrotonda())
    }
    
    func animazione(x: Double, y: Double, z: Double) {
        
        lineaVerticale.center.x = pallino.center.x
        lineaOrizzontale.center.y = pallino.center.y

        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: {
            
            self.pallino.center.x = self.center.x + self.frame.width*CGFloat(x)/4
            self.pallino.center.y = self.center.y + self.frame.height*CGFloat(-y)/4
           
            
        if abs(y) > 0.1 || abs(x) > 0.1 {
            self.frecce.alpha = 1
            if y > 0 && x > 0 {
                self.frecce.transform = CGAffineTransform.identity.rotated(by: atan(CGFloat(x/y))+CGFloat(M_PI))
            } else if y > 0 && x < 0 {
                self.frecce.transform = CGAffineTransform.identity.rotated(by: atan(CGFloat(x/y))+CGFloat.pi)
            } else if y < 0 && x < 0 {
                self.frecce.transform = CGAffineTransform.identity.rotated(by: atan(CGFloat(x/y)))
            } else if y < 0 && x > 0 {
                self.frecce.transform = CGAffineTransform.identity.rotated(by: atan(CGFloat(+x/y)))
            }
        } else {
                self.frecce.alpha = 0
            }
        }, completion: nil)
        if inMiniatura {
            frecce.alpha = 0
        }
    }
    

    func adattaPallinoELinee() {
        print(self.frame.size)
        if let superview = self.superview {
            lineaOrizzontale.frame.size.width = self.frame.width
            lineaVerticale.frame.size.height = self.frame.height
        }
    }
    
    func miniaturizza() {
        
        self.inMiniatura = true
        
        self.frame.size.width /= 2
        self.frame.size.height /= 2
        
        self.frecce.alpha = 0
        
//        self.lineaVerticale.alpha = 0
//        self.lineaOrizzontale.alpha = 0
        self.pallino.frame.size.width /= 2
        self.pallino.frame.size.height /= 2
        self.macchina.alpha = 0
        self.gTesto.alpha = 0
        self.gNumero.alpha = 0
        adattaPallinoELinee()
        
    }
    
    func ingrandisci() {
        self.frame.size = frame0.size
        self.inMiniatura = false
        self.frecce.alpha = 1
        
        self.pallino.frame.size.width *= 2
        self.pallino.frame.size.height *= 2
        
        self.macchina.alpha = 1
        self.gNumero.alpha = 1
        self.gTesto.alpha = 1
        adattaPallinoELinee()
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
