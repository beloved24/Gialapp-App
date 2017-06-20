//
//  ProfileViewController.swift
//  GialApp_App
//
//  Created by Antonio Romaniello on 16/06/2017.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var racerNumber: UITextField!
    @IBOutlet weak var racerName: UITextField!
    @IBOutlet weak var racerSurname: UITextField!
    @IBOutlet weak var favouriteCar: UITextField!
    @IBOutlet weak var otherCar: UITextField!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = blueMegaride
        navigationItem.title = "Reports"
        tableView.backgroundColor = blueMegaride
        configureProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell") as! ProfileTableViewCell
        cell.configure()
        
        return cell
    }
}

extension ProfileViewController {
    
    func configureProfile() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 101
        
        racerNumber.attributedPlaceholder = NSAttributedString(string: "RACE NUMBER", attributes: [NSForegroundColorAttributeName: placeholderGrey])
        racerName.attributedPlaceholder = NSAttributedString(string: "NAME", attributes: [NSForegroundColorAttributeName: placeholderGrey])
        racerSurname.attributedPlaceholder = NSAttributedString(string: "SURNAME", attributes: [NSForegroundColorAttributeName: placeholderGrey])
        favouriteCar.attributedPlaceholder = NSAttributedString(string: "PREFERED CAR", attributes: [NSForegroundColorAttributeName: placeholderGrey])
        otherCar.attributedPlaceholder = NSAttributedString(string: "OTHER CAR", attributes: [NSForegroundColorAttributeName: placeholderGrey])
    }
    
    func printFonts() {
        var c = 0
        for family: String in UIFont.familyNames
        {
            c += 1
            print("\(c): \(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print(" == \(names)")
            }
        }
    }
}
