//
//  ViewGforceUIView.swift
//  GialApp_App
//
//  Created by Andrew Amato on 22/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit
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
    
    
    
    let defaultSize: CGSize = CGSize(width: 100, height: 100)

    let frecce = Frecce(frame: CGRect(x: 0, y: 0, width: 360, height: 420), numeroDiFrecce: 6)
    
    @IBOutlet weak var lineaOrizzontale: UIImageView!
    @IBOutlet weak var lineaVerticale: UIImageView!
    @IBOutlet weak var pallino: UIImageView!
    
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
    
    
    func animazione(x: Double, y: Double, z: Double) {
        
        lineaVerticale.center.x = pallino.center.x
        lineaOrizzontale.center.y = pallino.center.y

        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: {
            
            self.pallino.center.x = self.center.x + self.frame.width*CGFloat(x)/4
            self.pallino.center.y = self.center.y + self.frame.height*CGFloat(-y)/4
            
            self.pallino.frame.size.width = self.defaultSize.width + self.defaultSize.width*CGFloat(-z)/4
            self.pallino.frame.size.height = self.defaultSize.height + self.defaultSize.height*CGFloat(-z)/3
            
            if y > 0 && x > 0 {
                self.frecce.transform = CGAffineTransform.identity.rotated(by: atan(CGFloat(x/y))+CGFloat(M_PI))
            } else if y > 0 && x < 0 {
                self.frecce.transform = CGAffineTransform.identity.rotated(by: atan(CGFloat(x/y))+CGFloat.pi)
            } else if y < 0 && x < 0 {
                self.frecce.transform = CGAffineTransform.identity.rotated(by: atan(CGFloat(x/y)))
            } else if y < 0 && x > 0 {
                self.frecce.transform = CGAffineTransform.identity.rotated(by: atan(CGFloat(+x/y)))
            }
            
        }, completion: nil)
        
    }
    

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
