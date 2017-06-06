//
//  TutorialSecondViewController.swift
//  GialApp_App
//
//  Created by Andrew Amato on 04/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

class TutorialSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
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
