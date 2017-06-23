//
//  ViewRuoteUIView.swift
//  GialApp_App
//
//  Created by Andrew Amato on 22/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

class ViewRuoteUIView: UIView {

    
    @IBOutlet weak var auto: UIImageView!
    @IBOutlet weak var axis: UIImageView!
    
    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var temp2: UILabel!
    @IBOutlet weak var temp3: UILabel!
    @IBOutlet weak var temp4: UILabel!
    
    @IBOutlet weak var ruota1: UIView!
    @IBOutlet weak var ruota2: UIView!
    @IBOutlet weak var ruota3: UIView!
    @IBOutlet weak var ruota4: UIView!

    @IBOutlet weak var temperaturaMini: UILabel!
    @IBOutlet weak var angoloDiAssetto: UILabel!
    
    var leRuote: [UIView] = []
    
    var temperature: [Int] = [20,20,20,20]
    var temperatureTesti: [UILabel] = []
    /*
    let posizioneMacchinaGrande = CGRect(x: 90, y: 40, width: 180, height: 285)
    let posizioneMacchinaPiccola = CGRect(x: 90, y: 40, width: 180, height: 285)

    
    let posizioniGrandi: [CGRect] = [CGRect(x: 94.5, y: 64, width: 30.5, height: 66), CGRect(x: 94.5, y: 64, width: 305, height: 66), CGRect(x: 94.5, y: 64, width: 305, height: 66), CGRect(x: 94.5, y: 64, width: 305, height: 66)]
    
    let posizioniPiccole: [CGRect] = [CGRect(x: 94.5, y: 64, width: 30.5/3.13, height: 66/2.5), CGRect(x: 94.5, y: 64, width: 305/3.13, height: 66/2.5), CGRect(x: 94.5, y: 64, width: 30.5/3.13, height: 66/2.5), CGRect(x: 94.5, y: 64, width: 30.5/3.13, height: 66/2.5)]
*/
    
    var grado: Int = 0
    
    var timer = Timer()
    var altroTimer = Timer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        leRuote = [ruota1,ruota2,ruota3,ruota4]
        temperatureTesti = [temp1, temp2, temp3, temp4]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func ingrandisci() {
        for ogni in self.subviews {
            ogni.alpha = 1
        }
        temperaturaMini.alpha = 0
        
        altroTimer.invalidate()
    }
    
    func miniaturizza() {
        for ogni in self.subviews {
            ogni.alpha = 0
        }
        temperaturaMini.alpha = 1
        
        altroTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (_) in
            self.grado += 1
            self.temperaturaMini.text = String(self.grado+20) + "°C"
        })
    }
    
    
    func preparaTutto() {
        
        leRuote = [ruota1,ruota2,ruota3,ruota4]
        
        temperatureTesti = [temp1, temp2, temp3, temp4]
        
        for ruota in leRuote {
            ruota.layer.cornerRadius = 5
            ruota.backgroundColor = UIColor.blue
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (_) in
            
            self.grado+=1
            
            for i in 0...3 {
                self.temperature[i] = self.grado%80 + 20
                self.temperatureTesti[i].text = String(self.temperature[i]) + "°C"
            }
            
            for ruota in self.leRuote {
                UIView.animate(withDuration: 0.4, animations: {
                    
                    ruota.backgroundColor = UIColor(hue: CGFloat( 0.825 - Double(self.grado%80+20)*0.66/80), saturation: 0.8, brightness: 0.8, alpha: 1)
                    
                })
            }
            
        }
        
        
        
    }
    /*
    func setView(<#parameters#>) -> <#return type#> {
        <#function body#>
    }*/
    
    
    
}
