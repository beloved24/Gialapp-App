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
        
     

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
//        navigationController?.navigationBar.barTintColor = UIColor(red: 32, green: 99, blue: 124, alpha: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
