//
//  MainUIViewController.swift
//  GialApp_App
//
//  Created by Andrew Amato on 22/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit
import CoreMotion

class MainUIViewController: UIViewController {

    @IBOutlet weak var view0: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet var viewRuote: ViewRuoteUIView!
    @IBOutlet var viewGforce: ViewGforceUIView!
    @IBOutlet var viewAccelerazione: ViewAccelerazioneUIView!
    @IBOutlet var viewLocked: ViewLockedUIView!
    
    
    let motionManager = CMMotionManager()
    
    
    //MARK: andrew
    var center0 = CGPoint()
    var center1 = CGPoint()
    var center2 = CGPoint()
    var center3 = CGPoint()
    var frame0 = CGRect()
    
    var initialFrameVelocita = CGRect()
    
    
    
    override func viewDidLoad() {
        
        center0 = view0.center
        center2 = view2.center
        center3 = view3.center
        
        frame0 = view0.frame
        
        navigationItem.title = "TEMPERATURA"
        
        super.viewDidLoad()
        motionManager.accelerometerUpdateInterval = 0.1
        
        motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
            
            if let data = data {
                self.viewGforce.animazione(x: data.acceleration.x, y: data.acceleration.y, z: data.acceleration.z)
                self.viewGforce.aggiornaLabel(numero: sqrt(pow(data.acceleration.x,2) + pow(data.acceleration.y,2) + pow(data.acceleration.z,2)))
                
            }
            
        }
        /*
        motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
            
            if let data = data {
            self.viewGforce.animazione(x: data.gravity.x, y: data.gravity.y, z: data.gravity.z)
                self.viewGforce.aggiornaLabel(numero: sqrt(pow(data.gravity.x,2) + pow(data.gravity.y,2) + pow(data.gravity.z,2)))
                
            }
            
        }*/
        

        
        
        //MARK: creating TAP GESTURE RECOGNIZER
        let tapToEnlarge0 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge1 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge2 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge3 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        view0.addGestureRecognizer(tapToEnlarge0)
        view1.addGestureRecognizer(tapToEnlarge1)
        view2.addGestureRecognizer(tapToEnlarge2)
        view3.addGestureRecognizer(tapToEnlarge3)
        
        
        //MARK: adding view0
        view0.addSubview(viewRuote)
        viewRuote.axis.center.x = viewRuote.center.x - 3
        viewRuote.assettoImage.center.x = viewRuote.axis.center.x
        viewRuote.axis.center.y = viewRuote.center.y - 70
        viewRuote.assettoImage.frame.origin.y = viewRuote.axis.center.y + 26
        viewRuote.assettoImage.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        viewRuote.preparaTutto()
        view0.layer.cornerRadius = 10.0
        view0.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        view0.layer.borderWidth = 1.0
        viewRuote.backgroundColor = .clear
        //viewRuote.temperaturaMini.alpha = 0
        
        
        
        
        
        //MARK: adding view1
        view1.addSubview(viewAccelerazione)
//        view1.layer.cornerRadius = 10.0
//        view1.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5).cgColor
//        view1.layer.borderWidth = 1.0


        //MARK: adding view2
        view2.addSubview(viewGforce)
        viewGforce.frame.size.width = view2.frame.width
        viewGforce.frame.size.height = view2.frame.height
        viewGforce.adattaPallinoELinee()
        viewGforce.macchina.alpha = 0
        
        
        view2.layer.cornerRadius = 10.0
        view2.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        view2.layer.borderWidth = 1.0
        viewGforce.backgroundColor = .clear
//        viewGforce.miniaturizza()
        viewGforce.frame0 = view0.frame
        
        //MARK: adding view3
        view3.addSubview(viewLocked)
        viewLocked.frame.size.width = view3.frame.width
        viewLocked.frame.size.height = view3.frame.height
        
        view3.layer.cornerRadius = 10.0
        view3.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        view3.layer.borderWidth = 1.0
        viewLocked.backgroundColor = .clear
        
        
        //MARK: settaggio view accelerazione (che sarebbe quella della velocità) con annesso slavataggio dei dati
        
        viewAccelerazione.framePiccolo = view1.frame
        viewAccelerazione.boundsPiccolo = view1.bounds
        viewAccelerazione.frameGrande = view0.frame
        viewAccelerazione.boundsGrande = view0.bounds
        viewAccelerazione.setInitialFrame()
        
        
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}


extension MainUIViewController {
    
    /// praticamente questa è la funzione che abbiamo sempre usato. sposta la view tappata al centro e porta quella al centro al posto della view tappata
    ///
    /// - Parameter gesture: il gesture recognizer che la chiamata. lo usiamo anche per capire qual è la view che è stata toccata
    
    func tapToEnlargeFunction (gesture: UIGestureRecognizer) {
        //la view che sta al centro è sempre la view con tag 0
        let destinationFrame = gesture.view!.frame
        let destinationCenter = (gesture.view?.center)!
        
        movingBackFunction(movingView: self.view.viewWithTag(99)!, at: destinationCenter, with: destinationFrame)
        movingViewAtCenter(movingView: gesture.view!)
        
    }
    
    /// questa funzione prende la view in ingresso e la sposta al centro. gli elementi contenuti all'interno delle singole view vengono gestiti dalle relative funzioni che stanno nelle classi personalizzate che abbiamo cerato.
    ///
    /// - Parameter movingView: la moving view è la view tappata, quindi la prendiamo dal gesture recognizer. prima pero di assergnarla alle varie funzioni delle classi personalizzate, viene castata al tipo corrispondente (individuato tramite la funzione is kind of).
    
    func movingViewAtCenter (movingView: UIView) {

        if (movingView.subviews.first!.isKind(of: ViewRuoteUIView.self)) {
            print("ho toccato la view delle ruote")
            //questa gesture view è quella da allargare
//            viewRuote.timer.invalidate()
            animaAlCentro(movingView: movingView, subViewOfType: .ViewRuoteUIView)
            navigationItem.title = "TEMPERATURA"
            movingView.tag = 99
        }
        else if (movingView.subviews.first!.isKind(of: ViewAccelerazioneUIView.self)) {
            print("ho toccato la view dell'accelerazione")
            animaAlCentro(movingView: movingView, subViewOfType: .ViewAccelerazioneUIView)
            navigationItem.title = "VELOCITÀ"
            movingView.tag = 99
        }
        else if  (movingView.subviews.first!.isKind(of: ViewGforceUIView.self)) {
            print("ho toccato la view dell FORZA G")
            animaAlCentro(movingView: movingView, subViewOfType: .ViewGforceUIView)
            navigationItem.title = "FORZA G"
            movingView.tag = 99
        }
        else if (movingView.subviews.first!.isKind(of: ViewLockedUIView.self)) {
            print("ho toccato la view bloccata")
            animaAlCentro(movingView: movingView, subViewOfType: .ViewLockedUIView)
            navigationItem.title = "BLOCCATO"
            movingView.tag = 99
        }
        
    }
   
    func movingBackFunction(movingView: UIView, at destinationCenter: CGPoint, with destinationFrame: CGRect) {
        
        if (movingView.subviews.first!.isKind(of: ViewRuoteUIView.self)) {
            print("la view al centro è la view delle ruote")
            //questa gesture view è quella da allargare
            viewRuote.timer.invalidate()
            viewRuote.timerAngolo.invalidate()
            
            animaIndietro(movingView: movingView, subViewOfType: .ViewRuoteUIView, destinationCenter: destinationCenter, destinationFrame: destinationFrame)
            movingView.tag = 500
        }
        else if (movingView.subviews.first!.isKind(of: ViewAccelerazioneUIView.self)) {
            print("la view al centro è la view dell'accelerazione")
            animaIndietro(movingView: movingView, subViewOfType: .ViewAccelerazioneUIView, destinationCenter: destinationCenter, destinationFrame: destinationFrame)
            movingView.tag = 500
        }
        else if  (movingView.subviews.first!.isKind(of: ViewGforceUIView.self)) {
            print("la view al centro è la view dell FORZA G")
            animaIndietro(movingView: movingView, subViewOfType: .ViewGforceUIView, destinationCenter: destinationCenter, destinationFrame: destinationFrame)
            movingView.tag = 500
        }
        else if (movingView.subviews.first!.isKind(of: ViewLockedUIView.self)){
            print("la view al centro è la view bloccata")
            animaIndietro(movingView: movingView, subViewOfType: .ViewLockedUIView, destinationCenter: destinationCenter, destinationFrame: destinationFrame)
            movingView.tag = 500
        }
    }
    
    func animaIndietro(movingView: UIView, subViewOfType: typeOfClass, destinationCenter: CGPoint, destinationFrame: CGRect) {
        switch subViewOfType {
        case .ViewAccelerazioneUIView:
            self.viewAccelerazione.velocitaMax.alpha = 0
            self.viewAccelerazione.velocitaMedia.alpha = 0
            self.viewAccelerazione.massimaLabel.alpha = 0
            self.viewAccelerazione.mediaLabel.alpha = 0
            self.viewAccelerazione.lineaSeparazione.alpha = 0
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                //quì gestisco la cosa che piaceva ad angelo
                let temporaryCenter = movingView.center
                movingView.frame.size.width /= 2
                movingView.frame.size.height /= 2
                movingView.center = temporaryCenter
                let newTemporaryBounds = movingView.bounds
                self.viewAccelerazione.changeTheSize(scaleFactor: 0.5, newTemporaryBounds: newTemporaryBounds)
               // movingViewSubview.setInMiniatura(initialFrame: self.initialFrameVelocita)
            }, completion: {
                if $0 {
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                        movingView.center = destinationCenter
                        movingView.frame = destinationFrame
                        //quì devi settare le impostazioni del contenuto
                        self.viewAccelerazione.setInMiniatura()
//
                    }, completion: {
                        if $0 {
                            movingView.isUserInteractionEnabled = true
                            
                        }
                    })
                }
            })
            
            break
        case .ViewGforceUIView:
            
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                movingView.frame.size.width /= 2
                movingView.frame.size.height /= 2
                movingView.center.x *= 2
                movingView.center.y *= 2
                //qui devo diminuire la dimensione del contenuto
  
                self.viewGforce.miniaturizza()
                /*
                self.viewGforce.inMiniatura = true
                
                self.viewGforce.frame.size.width /= 2
                self.viewGforce.frame.size.height /= 2
                
                self.viewGforce.frecce.alpha = 0
                
                self.viewGforce.lineaVerticale.alpha = 0
                self.viewGforce.lineaOrizzontale.alpha = 0
                self.viewGforce.pallino.frame.size.width /= 2
                self.viewGforce.pallino.frame.size.height /= 2
                self.viewGforce.macchina.alpha = 0
                self.viewGforce.gTesto.alpha = 0
                self.viewGforce.gNumero.alpha = 0
    */
                
            }, completion: {
                if $0 {
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                        movingView.center = destinationCenter
                        movingView.frame = destinationFrame
                        self.viewGforce.frame.size = destinationFrame.size
                        //quì devi settare le impostazioni del contenuto
                        self.viewGforce.adattaPallinoELinee()
                       }, completion: {
                        if $0 {
                            movingView.isUserInteractionEnabled = true
                        }
                    })
                }
            })
            break

        case .ViewRuoteUIView:
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                movingView.frame.size.width /= 2
                movingView.frame.size.height /= 2
                movingView.center.x *= 2
                movingView.center.y *= 2
                //qui devo diminuire la dimensione del contenuto
                
                
            }, completion: {
                if $0 {
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                        movingView.center = destinationCenter
                        movingView.frame = destinationFrame
                        
                        self.viewRuote.miniaturizza()
                        //qui devi settare le impostazioni del contenuto
                        self.viewRuote.temperaturaMini.center = CGPoint(x: 57.5, y: 83.5)
                        
                    }, completion: {
                        if $0 {
                            
                            
                            movingView.isUserInteractionEnabled = true

                        }
                    })
                }
            })
            break
        case .ViewLockedUIView:
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                movingView.frame.size.width /= 2
                movingView.frame.size.height /= 2
                movingView.center.x *= 2
                movingView.center.y *= 2
                //ViewLockedUIView.changeTheSize(<#T##ViewLockedUIView#> usando i protoolli ma non ci sono riuscito purtroppo
                let movingViewSubview = movingView.subviews.first as! ViewLockedUIView
                movingViewSubview.changeTheSize(scaleFactor: 0.5)
                
                
                
            }, completion: {
                if $0 {
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                        movingView.center = destinationCenter
                        movingView.frame = destinationFrame
                        //quì devi settare le impostazioni del contenuto
                        
                    }, completion: {
                        if $0 {
                            movingView.isUserInteractionEnabled = true
                        }
                    })
                }
            })

            
        }
    }
    
    
    
    
    
    
    /// per evitare ridondanza ho fatto a parte un'altra funzione che contiente l'animazione vera e propria. essa a seconda dei vari casi, oltre ad eseguire sempre la stessa parte di codice ogni volta (che pure si poteva mettere in una funzione a parte ma non volevo esagerare con le funzioni innestate)  che mi sposta la view, esegue a seconda del tipo anche il codice che ti allarga propriamente il contenuto
   ///
   /// - Parameters:
   ///   - movingView: la view presa dal gesture recognizer, quindi la view che è stata tappata
   ///   - subViewOfType:  questo serve per sapere quale view sto allargando in modo da pter disporre correttamente il contenuto della subview
   /// - Returns: il tag da assegnare alla view LA CUI SUBVIEW  è stata castata. si pu evitare, ma almento così posso fare una scrittura più compatta
    
    func animaAlCentro(movingView: UIView, subViewOfType: typeOfClass) {
        
//        var tagToAssignToView = Int()
        switch subViewOfType {
            
        case .ViewAccelerazioneUIView:
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                //qui raddoppio le dimenzsiono per fare la cosa che piacedva ad angelo
                let temporaryCenter = movingView.center //mi salvo il centro per poi riassegnarlo dopo il resize
                movingView.frame.size.width *= 2
                movingView.frame.size.height *= 2
                movingView.center = temporaryCenter
                let newTemporaryBounds = movingView.bounds
                self.viewAccelerazione.changeTheSize(scaleFactor: 2, newTemporaryBounds: newTemporaryBounds)
            }, completion: {
                if $0 {
                    //qui gestisco il movimento verso il centro vero e proprio
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                        movingView.center = self.center0
                        movingView.frame = self.frame0
                        //quì devi spostare il contenuto della view
                        self.viewAccelerazione.setFullSize()
                        
//                        self.viewAccelerazione.velocitaIsta.center = CGPoint(x:180, y: 210)
//                        self.viewAccelerazione.massimaLabel.frame = CGRect(x: 60, y: 342, width: 71, height: 30)
//                        self.viewAccelerazione.velocitaMax.frame = CGRect(x: 18, y: 360, width: 156, height: 60)
//                        self.viewAccelerazione.mediaLabel.frame = CGRect(x: 249, y: 342, width: 48, height: 39)
//                        self.viewAccelerazione.velocitaMedia.frame = CGRect(x: 203, y: 360, width: 136, height: 60)
                        
                        
                    }, completion: {
                        if $0 {
                            movingView.isUserInteractionEnabled = false
                        }
                    })
                    
                }
                
            })
            break
        case .ViewGforceUIView:
//            viewGforce.backgroundColor = UIColor.black
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                //qui raddoppio le dimenzsiono per fare la cosa che piacedva ad angelo
                let center = movingView.center
                movingView.frame.size.width *= 2
                movingView.frame.size.height *= 2
                movingView.center = center

                //quì devi allargare il contenuto della view
               
                self.viewGforce.ingrandisci()
                /*
                self.viewGforce.frame.size = self.frame0.size
                self.viewGforce.inMiniatura = false
                self.viewGforce.frecce.alpha = 1
                
                self.viewGforce.pallino.frame.size.width *= 2
                self.viewGforce.pallino.frame.size.height *= 2
                
                self.viewGforce.macchina.alpha = 1
                self.viewGforce.gNumero.alpha = 1
                self.viewGforce.gTesto.alpha = 1
                */
            }, completion: {
                self.viewGforce.adattaPallinoELinee()

//                self.viewGforce.lineaOrizzontale.frame.size.width = 360
                
                if $0 {
                    //qui gestisco il movimento verso il centro vero e proprio
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                        movingView.center = self.center0
                        movingView.frame = self.frame0
                        //quì devi spostare il contenuto della view
                        self.viewGforce.lineaOrizzontale.alpha = 1
                        self.viewGforce.lineaVerticale.alpha = 1

                        
                    }, completion: {
                        if $0 {
                            movingView.isUserInteractionEnabled = false
                        }
                    })
                    
                }
                
            })
            break
        case .ViewRuoteUIView:
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                //qui raddoppio le dimenzsiono per fare la cosa che piacedva ad angelo
                let center = movingView.center
                movingView.frame.size.width *= 2
                movingView.frame.size.height *= 2
                movingView.center = center
                //quì devi allargare il contenuto della view
                
            }, completion: {
                if $0 {
                    //qui gestisco il movimento verso il centro vero e proprio
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                        movingView.center = self.center0
                        movingView.frame = self.frame0
                        //quì devi spostare il contenuto della view
                        self.viewRuote.ingrandisci()
                        self.viewRuote.temperaturaMini.center = self.center0

                        
                    }, completion: {
                        if $0 {
                            movingView.isUserInteractionEnabled = false
                            self.viewRuote.preparaTutto()
                         


                        }
                    })
                    
                }
                
            })
            break
        case .ViewLockedUIView:
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                //qui raddoppio le dimenzsiono per fare la cosa che piacedva ad angelo
                let movingViewSubview = movingView.subviews.first as! ViewLockedUIView

                let center = movingView.center
                movingView.frame.size.width *= 2
                movingView.frame.size.height *= 2
                movingView.center = center
                movingViewSubview.changeTheSize(scaleFactor: 2)
            }, completion: {
                if $0 {
                    //qui gestisco il movimento verso il centro vero e proprio
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                        movingView.center = self.center0
                        movingView.frame = self.frame0
                        //quì devi spostare il contenuto della view
                        
                    }, completion: {
                        if $0 {
                            movingView.isUserInteractionEnabled = false
                        }
                    })
                    
                }
                
            })
            
        }
        
    }
}






