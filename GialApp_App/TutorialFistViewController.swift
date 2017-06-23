//
//  TutorialFistViewController.swift
//  GialApp_App
//
//  Created by Andrew Amato on 04/06/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

class TutorialFistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
}

extension TutorialFistViewController {
    
    func setNavigationBar () {
        //let navBarImageTitle = UIImageView(image: #imageLiteral(resourceName: "megaride"))
        //navBarImageTitle.frame = CGRect(x: 0, y: 0, width: 17, height: 17)
        //navBarImageTitle.contentMode = .scaleAspectFit
        //navigationItem.titleView = navBarImageTitle
        navigationItem.title = "RACÉ"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
