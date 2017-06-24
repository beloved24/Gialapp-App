//
//  MyCustomImageView.swift
//  GialApp_App
//
//  Created by Andrew Amato on 09/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit
enum imageType {
    case big
    case small
    case medium
}

class MyCustomImageView: UIImageView {

    var touchedArea = ""
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        if let touch = touches.first {
            let widthOfTheImage = self.frame.width
            let position : CGPoint = touch.location(in: self)
            let xANDy = (position.x, position.y)
            
            print("touched on x: \(position.x) , y: \(position.y)")
            
            if widthOfTheImage < 335 {
                print("dovrebbe essere un iPhone 6s o 7 in landscape con larghezza immagine a 335")
                //iPhone 6s e 7 landscape
                //openSelectedArea(area: "ugeriug")
                
                switch xANDy {
                case let (x,y) where isInRange(value: Float(x), leftLimit: 131, rightLimit: 201) && isInRange(value: Float(y), leftLimit: 31, rightLimit: 46):
                    print("specchietto retrovisore")
                    touchedArea = "specchietto retrovisore"
                    openSelectedArea(area: touchedArea, type: .small)
                    break
                    
                case let (x,y) where isInRange(value: Float(x), leftLimit: 0, rightLimit: 333) && isInRange(value: Float(y), leftLimit: 0, rightLimit: 114) :
                    print("parabrezza")
                    touchedArea = "parabrezza"
                    openSelectedArea(area: touchedArea, type: .big)
                    break
                    
                    
                case let (x,y) where isInRange(value: Float(x), leftLimit: 24, rightLimit: 119) && isInRange(value: Float(y), leftLimit: 100, rightLimit: 188):
                    print("volante")
                    touchedArea = "volante"
                    openSelectedArea(area: touchedArea, type: .big)
                    break
                
                case let (x,y) where isInRange(value: Float(x), leftLimit: 120, rightLimit: 215) && isInRange(value: Float(y), leftLimit: 114, rightLimit: 187):
                    print("plancia centrale")
                    touchedArea = "plancia centrale"
                    openSelectedArea(area: touchedArea, type: .big)
                    break
                    
                case let (x,y) where isInRange(value: Float(x), leftLimit: 212, rightLimit: 333) && isInRange(value: Float(y), leftLimit: 108, rightLimit: 187):
                    print("plancia destra")
                    touchedArea = "plancia destra"
                    openSelectedArea(area: touchedArea, type: .big)
                    break
                
                case let (x,y) where isInRange(value: Float(x), leftLimit: 140, rightLimit: 194) && isInRange(value: Float(y), leftLimit: 189, rightLimit: 245):
                    print("tunnel centrale")
                    touchedArea = "tunnel centrale"
                    openSelectedArea(area: touchedArea, type: .small)
                    break
                    
                default:
                    print("qualcosa è andato storto")
                    print("touched on x: \(position.x), y: \(position.y) =")
                    break
                }
                
            }
            
            else if widthOfTheImage > 335 && widthOfTheImage < 370 {
                //iphone 6s+ e 7+ landscape
                
            }
            else if widthOfTheImage > 370 && widthOfTheImage < 376 {
                //print("dovrebbe essere un iPhone 6s o 7 in portrait con larghezza immagine a 335")
                //iphone 6s e 7 portrait
               switch xANDy {
                case let (x,y) where isInRange(value: Float(x), leftLimit: 148, rightLimit: 225) && isInRange(value: Float(y), leftLimit: 34, rightLimit: 50):
                    print("specchietto retrovisore")
                    touchedArea = "specchietto retrovisore"
                    openSelectedArea(area: touchedArea, type: .small)
                    break
               
               case let (x,y) where isInRange(value: Float(x), leftLimit: 0, rightLimit: 375) && isInRange(value: Float(y), leftLimit: 0, rightLimit: 114) :
                print("parabrezza")
                touchedArea = "parabrezza"
                openSelectedArea(area: touchedArea, type: .big)
                //qua non ci vuole il break
                
  
                case let (x,y) where isInRange(value: Float(x), leftLimit: 27, rightLimit: 134) && isInRange(value: Float(y), leftLimit: 102, rightLimit: 210):
                    print("volante")
                    touchedArea = "volante"
                    openSelectedArea(area: touchedArea, type: .big)
                    break
                    
                
                case let (x,y) where isInRange(value: Float(x), leftLimit: 141, rightLimit: 239) && isInRange(value: Float(y), leftLimit: 119, rightLimit: 207):
                    print("plancia centrale")
                    touchedArea = "plancia centrale"
                    openSelectedArea(area: touchedArea, type: .big)
                    break
                    
                case let (x,y) where isInRange(value: Float(x), leftLimit: 240, rightLimit: 375) && isInRange(value: Float(y), leftLimit: 119, rightLimit: 211):
                    print("plancia destra")
                    touchedArea = "plancia destra"
                    openSelectedArea(area: touchedArea, type: .big)
                    break
                    
                case let (x,y) where isInRange(value: Float(x), leftLimit: 157, rightLimit: 219) && isInRange(value: Float(y), leftLimit: 212, rightLimit: 273):
                    print("tunnel centrale")
                    touchedArea = "tunnel centrale"
                    openSelectedArea(area: touchedArea, type: .small)
                    break
                    
                default:
                    print("qualcosa è andato storto")
                    print("touched on x: \(position.x), y: \(position.y) =")
                    break
                }
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
    
    func openSelectedArea(area: String, type: imageType) {
        print("open selected area")
        let viewOfTheSelectedArea = UIView()
        viewOfTheSelectedArea.frame = (superview?.frame)!
        viewOfTheSelectedArea.center = (superview?.center)!
        viewOfTheSelectedArea.backgroundColor = UIColor.init(red: 0.09, green: 0.39, blue: 0.49, alpha: 1.0)
        
        
        let imageArea = MyCustomImageView()
        imageArea.image = UIImage(named: area)
        imageArea.contentMode = .scaleAspectFit
        switch type {
        case .big:
            imageArea.frame.size.width = viewOfTheSelectedArea.frame.size.width
            break
        case .medium:
            imageArea.frame.size.width = viewOfTheSelectedArea.frame.size.width/2
            break
        case .small:
            imageArea.frame.size.width = viewOfTheSelectedArea.frame.size.width/3
            break
        }
        imageArea.frame.size.height = imageArea.frame.size.width
        imageArea.center = viewOfTheSelectedArea.center
        imageArea.backgroundColor = UIColor.init(red: 0.09, green: 0.39, blue: 0.49, alpha: 1.0)
        
        let okButton = UIButton(type: .custom)
        okButton.setTitle("OK", for: .normal)
        okButton.backgroundColor = UIColor.clear
        okButton.titleLabel?.font = UIFont(name: "BebasNeue", size: 25)
        okButton.frame.size.width = viewOfTheSelectedArea.frame.width/2
        okButton.frame.size.height = (okButton.frame.width*3)/17
        okButton.titleLabel?.contentMode = .scaleAspectFit
        okButton.center.x = viewOfTheSelectedArea.center.x
        okButton.center.y = viewOfTheSelectedArea.frame.height - okButton.frame.height
        okButton.addTarget(self, action: #selector(tapToCloseFunction), for: .touchUpInside)
        viewOfTheSelectedArea.addSubview(okButton)
        
        
//        let tapToclose = UITapGestureRecognizer(target: self, action: #selector(tapToCloseFunction))
//        viewOfTheSelectedArea.addGestureRecognizer(tapToclose)
        
        viewOfTheSelectedArea.addSubview(imageArea)
        superview?.addSubview(viewOfTheSelectedArea)
    }
    
    func tapToCloseFunction(sender: UIButton!) {
        sender.superview?.removeFromSuperview()
    
    }

}
