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
    @IBOutlet weak var assettoImage: UIImageView!
    @IBOutlet weak var angoloAssetto: UILabel!
    
    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var temp2: UILabel!
    @IBOutlet weak var temp3: UILabel!
    @IBOutlet weak var temp4: UILabel!
    
    @IBOutlet weak var ruota1: UIView!
    @IBOutlet weak var ruota2: UIView!
    @IBOutlet weak var ruota3: UIView!
    @IBOutlet weak var ruota4: UIView!

    @IBOutlet weak var temperaturaMini: UILabel!
    
    var leRuote: [UIView] = []
    
    var temperature: [Int] = [20,20,20,20]
    var temperatureTesti: [UILabel] = []
    
    var angle: Double = 0
    var reverse = false

    /*
    let posizioneMacchinaGrande = CGRect(x: 90, y: 40, width: 180, height: 285)
    let posizioneMacchinaPiccola = CGRect(x: 90, y: 40, width: 180, height: 285)

    
    let posizioniGrandi: [CGRect] = [CGRect(x: 94.5, y: 64, width: 30.5, height: 66), CGRect(x: 94.5, y: 64, width: 305, height: 66), CGRect(x: 94.5, y: 64, width: 305, height: 66), CGRect(x: 94.5, y: 64, width: 305, height: 66)]
    
    let posizioniPiccole: [CGRect] = [CGRect(x: 94.5, y: 64, width: 30.5/3.13, height: 66/2.5), CGRect(x: 94.5, y: 64, width: 305/3.13, height: 66/2.5), CGRect(x: 94.5, y: 64, width: 30.5/3.13, height: 66/2.5), CGRect(x: 94.5, y: 64, width: 30.5/3.13, height: 66/2.5)]
*/
    
    var grado: Int = 0
    
    var timer = Timer()
    var timerAngolo = Timer()
    
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
    }
    
    func miniaturizza() {
        for ogni in self.subviews {
            ogni.alpha = 0
        }
        temperaturaMini.alpha = 1
        temperaturaMini.text = String(grado+20) + "°C"
    }
    
    func preparaTutto() {
        
        leRuote = [ruota1,ruota2,ruota3,ruota4]
        
        temperatureTesti = [temp1, temp2, temp3, temp4]
        
        for ruota in leRuote {
            ruota.layer.cornerRadius = 5
            ruota.backgroundColor = UIColor.blue
        }
        
        
//        timerAngolo = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { (_) in
//            
//            self.angoloAssetto.text = String(Double((self.angle * 180) / Float.pi).arrotondaInt()) + "°"
//            
//            if !self.reverse {
//                if self.angle <= (Float.pi / 2) {
//                    self.angle += (Float.pi / 320)
//                } else {
//                    self.reverse = true
//                }
//            } else {
//                if self.angle >= -(Float.pi / 2) {
//                    self.angle -= (Float.pi / 320)
//                } else {
//                    self.reverse = false
//                }
//            }
//            
//            self.assettoImage.transform = CGAffineTransform(rotationAngle: CGFloat(self.angle))
//        })
        
//        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (_) in
//            
//            self.grado+=1
//            
//            for i in 0...3 {
//                self.temperature[i] = self.grado%80 + 20
//                self.temperatureTesti[i].text = String(self.temperature[i]) + "°C"
//            }
//            
//            
//            for ruota in self.leRuote {
//                UIView.animate(withDuration: 0.4, animations: {
//                    
//                    ruota.backgroundColor = UIColor(hue: CGFloat( 0.825 - Double(self.grado%80+20)*0.66/80), saturation: 0.8, brightness: 0.8, alpha: 1)
//                    
//                })
//            }
//        }
    }
    
//    func aggiornaAngoloAssetto(x: Double, y: Double) {
//        angle = Double(atan(y/x))
//        if angle >= -2 && angle <= 2 {
//            angle = 0
//        }
//        angoloAssetto.text = String(angle.arrotondaInt()) + "°"
//        self.assettoImage.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
//    }

    
    func aggiornaTemperatura(x: Double, y: Double) { // TUTTO MOLTO FAKE
        
        if y >= -0.05 { // devo partire da -0.05 (un numero epsylon arbitrariamente piccolo) a causa delle oscillazioni intorno allo zero dei dati del sensore
            for i in 0...3 {
                temperature[i] -= Int(exp(-y)) //sto supponendo che in accelerazione si raffreddino tutte le ruote, poco all'inizio (elevata accelerazione lungo y) e tanto a velocità elevate ('o vient, cos) con accelerazione tendente a zero (escludo il caso di burnout in cui si riscaldano le ruote posteriori). Tutto questo se non sto dicendo strunzate: all'atenzione del Si. Angelo de Angelis
                if temperature[i] < 20 {
                    temperature[i] = 20
                }
            }
        } else if y < -0.05 {
            for i in 0...3 {
                    temperature[i] += Int(exp(-y)) //sto supponendo che in frenata si riscaldino tutte le ruote, molto all'inizio (forte decellerazione) e poco a decelerazioni minori
                if temperature[i] > 80 {
                    temperature[i] = 80
                }
            }
        }
        
        if x > 0.05 {
            temperature[0] += Int(exp(x)) //sto sempre supponendo eh, nun me guardate stuort! sterzate forti a destra comportano surriscaldamento elevato della ruota anteriore sinistra. Sterzate minori, meno surriscaldamento
            if temperature[0] > 80 {
                temperature[0] = 80
            }
        
            temperature[1] += Int(2 * x) //sterzate forti a destra comportano surriscaldamento moderato della ruota anteriore destra. Sterzate minori, ancora meno surriscaldamento
            if temperature[1] > 80 {
                temperature[1] = 80
            }
        
            temperature[2] += Int(x) //sterzate forti a destra comportano surriscaldamento ancora minore della ruota posteriore sinistra. Sterzate minori, ancora meno surriscaldamento
            if temperature[2] > 80 {
                temperature[2] = 80
            }
            

        } else if x < -0.05 {
            temperature[1] += Int(exp(-x)) //sterzate forti a sinistra comportano surriscaldamento elevato della ruota anteriore destra. Sterzate minori, meno surriscaldamento
            if temperature[1] > 80 {
                temperature[1] = 80
            }
            
            temperature[0] += Int(-2 * x) //sterzate forti a sinistra comportano surriscaldamento moderato della ruota anteriore sinistra. Sterzate minori, ancora meno surriscaldamento
            if temperature[0] > 80 {
                temperature[0] = 80
            }
            
            temperature[3] += Int(-x) //sterzate forti a sinistra comportano surriscaldamento ancora minore della ruota posteriore destra. Sterzate minori, ancora meno surriscaldamento
            if temperature[3] > 80 {
                temperature[3] = 80
            }
        }
        
        angle = x
        angoloAssetto.text = String(((angle * 180) / Double.pi).arrotondaInt()) + "°"
        assettoImage.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        
        for i in 0...3 {
//            self.temperature[i] = self.grado%80 + 20
            leRuote[i].backgroundColor = UIColor(hue: CGFloat( 0.825 - Double(temperature[i])*0.66/60), saturation: 0.8, brightness: 0.8, alpha: 1)
            temperatureTesti[i].text = String(temperature[i]) + "°C"
        }
    }
}
