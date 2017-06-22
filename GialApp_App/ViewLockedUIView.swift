//
//  ViewLockedUIView.swift
//  GialApp_App
//
//  Created by Andrew Amato on 22/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit


class ViewLockedUIView: UIView, ViewLockedUIViewProtocol {
    
    @IBOutlet weak var lucchetto: UIImageView!
    
    
    open func changeTheSize(scaleFactor: CGFloat) {
        let viewCenterSaved = center
        let luccettoCenterSaved = lucchetto.center
        
        frame.size.width *= scaleFactor
        frame.size.height *= scaleFactor
        //center = viewCenterSaved
        
        lucchetto.frame.size.width *= scaleFactor
        lucchetto.frame.size.height *= scaleFactor
        lucchetto.center = luccettoCenterSaved
    }
   
   
}


protocol ViewLockedUIViewProtocol {
    func changeTheSize(scaleFactor: CGFloat)
}
