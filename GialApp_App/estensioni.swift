//
//  File.swift
//  GialApp_App
//
//  Created by Angelo De Angelis on 29/05/2017.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import Foundation
import CoreMotion


extension Double {
    func roundedNostro() -> Double {
        return (self * 100).rounded()/100
    }
}

extension CMAttitude {
    
    
    func stampareInGradi () -> String {
        
        return String((self.roll.roundedNostro()*180/Double.pi).roundedNostro()) + "\n" + String((self.pitch.roundedNostro()*180/Double.pi).roundedNostro()) + "\n" + String((self.yaw.roundedNostro()*180/Double.pi).roundedNostro())
        
    }
    
}
