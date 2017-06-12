//
//  MyCustomImageView.swift
//  GialApp_App
//
//  Created by Andrew Amato on 09/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

class MyCustomImageView: UIImageView {

    var touchedArea = ""
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        if let touch = touches.first {
            let widthOfTheImage = self.frame.width
            let position : CGPoint = touch.location(in: self)
            let xANDy = (position.x, position.y)
            
            //print("touched on x: \(position.x) , y: \(position.y)")
            
            if widthOfTheImage < 335 {
                print("dovrebbe essere un iPhone 6s o 7 in landscape con larghezza immagine a 335")
                //iPhone 6s e 7 landscape
                //openSelectedArea(area: "ugeriug")
                
                switch xANDy {
                case let (x,y) where isInRange(value: Float(x), leftLimit: 131, rightLimit: 201) && isInRange(value: Float(y), leftLimit: 31, rightLimit: 46):
                    print("specchietto retrovisore")
                    touchedArea = "specchietto retrovisore"
                    openSelectedArea(area: touchedArea)
                    
                    
                case let (x,y) where isInRange(value: Float(x), leftLimit: 0, rightLimit: 333) && isInRange(value: Float(y), leftLimit: 0, rightLimit: 100) :
                    print("parabrezza")
                    touchedArea = "parabrezza"
                    openSelectedArea(area: touchedArea)
                    
                case let (x,y) where isInRange(value: Float(x), leftLimit: 24, rightLimit: 119) && isInRange(value: Float(y), leftLimit: 100, rightLimit: 188):
                    print("volante")
                    touchedArea = "volante"
                    openSelectedArea(area: touchedArea)
                
                case let (x,y) where isInRange(value: Float(x), leftLimit: 120, rightLimit: 215) && isInRange(value: Float(y), leftLimit: 102, rightLimit: 187):
                    print("plancia centrale")
                    touchedArea = "plancia centrale"
                    openSelectedArea(area: touchedArea)
                    
                case let (x,y) where isInRange(value: Float(x), leftLimit: 212, rightLimit: 333) && isInRange(value: Float(y), leftLimit: 108, rightLimit: 187):
                    print("plancia destra")
                    touchedArea = "plancia destra"
                    openSelectedArea(area: touchedArea)
                
                case let (x,y) where isInRange(value: Float(x), leftLimit: 140, rightLimit: 194) && isInRange(value: Float(y), leftLimit: 189, rightLimit: 245):
                    print("tunnel centrale")
                    touchedArea = "tunnel centrale"
                    openSelectedArea(area: touchedArea)
                    
                default:
                    print("qualcosa è andato storto")
                    print("touched on x: \(position.x), y: \(position.y) =")
                }
            }
                
            else if widthOfTheImage > 335 && widthOfTheImage < 370 {
                //iphone 6s+ e 7+ landscape
            }
            else if widthOfTheImage > 370 && widthOfTheImage < 376 {
                //iphone 6s e 6 portrait
            }
            else if widthOfTheImage > 376 && widthOfTheImage < 417 {
                //iphone 6s+ e 7+ portrait
            }
            
//            switch xANDy {
//            case let (x,y) where x >= 0 && y < 115:
//                print("touched on x: \(position.x), y: \(position.y) = parabrezza")
//                //case let (x,y) where
//            default:
//                print("touched on x: \(position.x), y: \(position.y) =")
//            }
            
        }
        
    }
    
    private func isInRange(value: Float, leftLimit: Float, rightLimit: Float) -> Bool {
        if value >= leftLimit && value <= rightLimit {
            return true
        }
        return false
    }
    
    func openSelectedArea(area: String) {
        print("open selected area")
        let viewOfTheSelectedArea = UIView()
        viewOfTheSelectedArea.frame = (superview?.frame)!
        viewOfTheSelectedArea.center = (superview?.center)!
        viewOfTheSelectedArea.backgroundColor = UIColor.green
        
        
        let imageArea = MyCustomImageView()
        imageArea.image = UIImage(named: area)
        imageArea.contentMode = .scaleAspectFit
        imageArea.frame.size.width = viewOfTheSelectedArea.frame.size.width/3
        imageArea.frame.size.height = imageArea.frame.size.width
        imageArea.center = viewOfTheSelectedArea.center
        imageArea.backgroundColor = UIColor.red
        
        let tapToclose = UITapGestureRecognizer(target: self, action: #selector(tapToCloseFunction))
        viewOfTheSelectedArea.addGestureRecognizer(tapToclose)
        
        viewOfTheSelectedArea.addSubview(imageArea)
        superview?.addSubview(viewOfTheSelectedArea)
    }
    
    func tapToCloseFunction(gesture: UIGestureRecognizer) {
        gesture.view?.removeFromSuperview()
    }

}
