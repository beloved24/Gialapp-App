//
//  ViewLockedUIView.swift
//  GialApp_App
//
//  Created by Andrew Amato on 22/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

class ViewAccelerazioneUIView: UIView {

  
    @IBOutlet weak var velocitaIsta: UILabel!
    @IBOutlet weak var velocitaMax: UILabel!
    @IBOutlet weak var velocitaMedia: UILabel!
    @IBOutlet weak var massimaLabel: UILabel!
    @IBOutlet weak var mediaLabel: UILabel!
    
    
    open func changeTheSize(scaleFactor: CGFloat) {
        let viewCenterSaved = center
        let velocitainstaCenterSaved = velocitaIsta.center
        
        if frame.size.width > 350 {
            velocitaMax.alpha = 0
            velocitaMedia.alpha = 0
            massimaLabel.alpha = 0
            mediaLabel.alpha = 0
        }
        velocitaIsta.frame.size.width *= scaleFactor
        velocitaIsta.frame.size.height *= scaleFactor
        velocitaIsta.center = velocitainstaCenterSaved
        
        frame.size.width *= scaleFactor
        frame.size.height *= scaleFactor
        center = viewCenterSaved
        
    }
    
    func setInitialFrame(initialFrame: CGRect, initialCenter: CGPoint)  {
        frame = initialFrame
        center = initialCenter
        velocitaIsta.center = initialCenter
        velocitaIsta.frame.size.width = initialFrame.width/2
        velocitaIsta.frame.size.height = initialFrame.height/2
    }

}
