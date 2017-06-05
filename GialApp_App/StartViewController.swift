//
//  ViewController.swift
//  GialApp_App
//
//  Created by Andrew Amato on 18/05/17.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavigationBar () {
        let navBarImageTitle = UIImageView(image: #imageLiteral(resourceName: "logo_megaride"))
        navigationItem.titleView = navBarImageTitle
    }
    
}

