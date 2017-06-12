//
//  TutorialSecondViewController.swift
//  GialApp_App
//
//  Created by Andrew Amato on 04/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

class TutorialSecondViewController: UIViewController {

    //MARK: outlets and properties
    @IBOutlet weak var oAuto: MyCustomImageView!
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        print("per l'iphone modello: \(UIDevice.current.name) \n con orientazione \(String(describing: UIDevice.current.orientation))  \nsi ha per l'immagine dell'auto:\nlarghezza: \(oAuto.frame.width) \nlunghezza \(oAuto.frame.height) ")
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //setNavigationBar()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension TutorialSecondViewController {
    
    func setNavigationBar () {
        let navBarImageTitle = UIImageView(image: #imageLiteral(resourceName: "megaride"))
        navBarImageTitle.frame = CGRect(x: 0, y: 0, width: 17, height: 17)
        navBarImageTitle.contentMode = .scaleAspectFit
        //navBarImageTitle.center = navigationItem.titleView?.center
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationItem.titleView = navBarImageTitle
    }
    
    
    
}
