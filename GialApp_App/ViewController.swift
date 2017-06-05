//
//  ViewController.swift
//  GialApp_App
//
//  Created by Andrew Amato on 18/05/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation


class transizioneAnimata: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.view(forKey: .from)
        let theTransform = CGAffineTransform(rotationAngle: 1).scaledBy(x: 0.4, y: 0.7)
        
        let toView = transitionContext.view(forKey: .to)
        
    
        toView?.frame = CGRect(x: 100, y: 100, width: 300, height: 500)
        
        UIView.animate(withDuration: 3, animations: {
            fromView?.transform = theTransform
        }) { (_) in
            transitionContext.containerView.addSubview(toView!)
            
            UIView.animate(withDuration: 1, animations: { 
                toView?.frame = transitionContext.containerView.frame
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }
        
        print(toView?.subviews)
        print(toView?.frame)
        
    }
}


class ViewController: UIViewController, CLLocationManagerDelegate, UIViewControllerTransitioningDelegate {

    
    @IBOutlet weak var diagView: UIView!
    @IBOutlet weak var pallino: UIView!
    
    
    @IBOutlet weak var attualeLabel: UILabel!
    @IBOutlet weak var riferimentoLabel: UILabel!
    @IBOutlet weak var velocitaLabel: UILabel!
    
    
    var attitudeRiferimento: CMAttitude?
    var attitudeMoltiplicata: CMAttitude = CMAttitude()

    var ourTimer: Timer = Timer()
    
    let manager = CMMotionManager()    
    let locationManager = CLLocationManager()
    
    let animatore = transizioneAnimata()
    
    
    @IBAction func salvaDefault () {
        attitudeRiferimento = (self.manager.deviceMotion?.attitude)!
        if let attitudeRiferimento = attitudeRiferimento {
        riferimentoLabel.text = attitudeRiferimento.stampareInGradi()
        
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var velocitakmh = (locations.first?.speed)!*3.6
        velocitaLabel.text = String(velocitakmh)
        
    }
    
    
    override func viewDidLoad() {
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
        
        super.viewDidLoad()

        let tapOnDiag = UITapGestureRecognizer(target: self, action: #selector(presentalo))
        diagView.addGestureRecognizer(tapOnDiag)
        
        
        manager.deviceMotionUpdateInterval = 1
        manager.startDeviceMotionUpdates(to: .main) { (data, error) in
            if let data = data {
            self.pallino.center.x = CGFloat(data.gravity.x)*self.diagView.frame.width/4 + self.diagView.frame.width/2
            self.pallino.center.y = CGFloat(data.gravity.z)*self.diagView.frame.height/4 + self.diagView.frame.height/2
            
            self.attitudeMoltiplicata = (self.manager.deviceMotion?.attitude)!
            
            if self.attitudeRiferimento != nil {
//                self.attitudeMoltiplicata.multiply(byInverseOf: self.attitudeRiferimento!)
            }

            self.attualeLabel.text = self.attitudeMoltiplicata.stampareInGradi()

        }
   }
        
        locationManager.delegate = self
        
        locationManager.distanceFilter = 2
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func presentalo() {
        
        let theVC = storyboard?.instantiateViewController(withIdentifier: "gForce")
        theVC?.transitioningDelegate = self
        
        present(theVC!, animated: true) { 
            print("fatto")
        }
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
    return animatore
    }

}
