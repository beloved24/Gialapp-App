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
    
    let motionManager = CMMotionManager()
    
    
    //MARK: andrew
    var center0 = CGPoint()
    var center1 = CGPoint()
    var center2 = CGPoint()
    var center3 = CGPoint()
    var frame0 = CGRect()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view0.addSubview(viewRuote)
        view1.addSubview(viewAccelerazione)
        viewAccelerazione.frame.size.width = view1.frame.width
        viewAccelerazione.frame.size.height = view1.frame.height
        
        let tapToEnlarge0 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge1 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge2 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        let tapToEnlarge3 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToEnlargeFunction))
        
        view0.addGestureRecognizer(tapToEnlarge0)
        view1.addGestureRecognizer(tapToEnlarge1)
        view2.addGestureRecognizer(tapToEnlarge2)
        view3.addGestureRecognizer(tapToEnlarge3)
        
        center0 = view0.center
        center1 = view1.center
        center2 = view2.center
        center3 = view3.center

        frame0 = view0.frame
        
        print(frame0)
        
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
        let destinationCenter = gesture.view?.center
        
        //movingBackFunction(movingView: self.view.viewWithTag(99)! as! MyCustomUIView, at: destinationCenter!, with: destinationFrame)
        movingViewAtCenter(movingView: gesture.view!)
        
    }
    
    /// questa funzione prende la view in ingresso e la sposta al centro. gli elementi contenuti all'interno delle singole view vengono gestiti dalle relative funzioni che stanno nelle classi personalizzate che abbiamo cerato
    ///
    /// - Parameter movingView: la moving view è la view tappata, quindi la prendiamo dal gesture recognizer. prima pero di assergnarla alle varie funzioni delle classi personalizzate, viene castata al tipo corrispondente (individuato tramite la funzione is kind of).
    func movingViewAtCenter (movingView: UIView) {
        if (movingView.subviews.first!.isKind(of: ViewRuoteUIView.self)) {
            print("ho toccato la view delle ruote")
            let gestureView = movingView.subviews.first as! ViewRuoteUIView
            //questa gesture view è quella da allargare
            movingView.tag = animaAlCentro(movingView: movingView, subViewOfType: .ViewRuoteUIView)
        }
        else if (movingView.subviews.first!.isKind(of: ViewAccelerazioneUIView.self)) {
            print("ho toccato la view dell'accelerazione")

            let gestureView = movingView.subviews.first as! ViewAccelerazioneUIView
            movingView.tag = animaAlCentro(movingView: gestureView, subViewOfType: .ViewAccelerazioneUIView)
        }
        else if  (movingView.subviews.first!.isKind(of: ViewGforceUIView.self)) {
            print("ho toccato la view dell FORZA G")

            let gestureView = movingView.subviews.first as! ViewGforceUIView
            movingView.tag = animaAlCentro(movingView: gestureView, subViewOfType: .ViewGforceUIView)
        }
        
    }

    /// per evitare ridondanza ho fatto a parte un'altra funzione che contiente l'animazione vera e propria. essa a seconda dei vari casi, oltre ad eseguire sempre la stessa parte di codice ogni volta (che pure si poteva mettere in una funzione a parte ma non volevo esagerare con le funzioni innestate)  che mi sposta la view, esegue a seconda del tipo anche il codice che ti allarga propriamente il contenuto
   ///
   /// - Parameters:
   ///   - movingView: la view presa dal gesture recognizer, quindi la view che è stata tappata
   ///   - subViewOfType:  questo serve per sapere quale view sto allargando in modo da pter disporre correttamente il contenuto della subview
   /// - Returns: il tag da assegnare alla view LA CUI SUBVIEW  è stata castata.
    
    func animaAlCentro(movingView: UIView, subViewOfType: typeOfClass) -> Int {
        
        var tagToAssignToView = Int()
        switch subViewOfType {
        case .ViewAccelerazioneUIView:
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
                        
                    }, completion: {
                        if $0 {
                            tagToAssignToView = 99
                        }
                    })
                    
                }
                
            })
            return tagToAssignToView
        case .ViewGforceUIView:
        
            return tagToAssignToView
        case .ViewRuoteUIView:
            return tagToAssignToView
        default:
            print("fratè fatt a rot")
            break
        }
                movingView.isUserInteractionEnabled = false
    }
}






