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
    
    func setInitialFrame(initialFrame: CGRect)  {
        frame.size = initialFrame.size
        velocitaIsta.alpha = 1
        velocitaMax.alpha = 0
        velocitaMedia.alpha = 0
        massimaLabel.alpha = 0
        mediaLabel.alpha = 0
        velocitaIsta.center = center
        
    }
    
    func setInMiniatura(initialFrame: CGRect) {
        print("sto dentro la setInitialFrame \(frame)")
        self.frame.size.width /= 2
        self.frame.size.height /= 2
        velocitaIsta.center = center
        
        velocitaMax.alpha = 0
        velocitaMedia.alpha = 0
        massimaLabel.alpha = 0
        mediaLabel.alpha = 0
    }
    
    func setFullSize (destinationFrame: CGRect) {
        print("sto dentro la setInitialFrame \(frame)")
        self.frame.size = destinationFrame.size
        velocitaIsta.frame.size.width = frame.width/2
        velocitaIsta.adjustsFontSizeToFitWidth = true
        
        velocitaMax.center.x = destinationFrame.width/4
        velocitaMax.center.y = 420 - velocitaMax.frame.height
        
        
        velocitaMax.alpha = 1
        
        
        velocitaMedia.alpha = 1
        massimaLabel.alpha = 1
        mediaLabel.alpha = 1
    }

}
