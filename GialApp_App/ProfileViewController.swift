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
    @IBOutlet weak var racerImage: UIImageView!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = blueMegaride
        navigationItem.title = "REPORTS"
        tableView.backgroundColor = blueMegaride
        imagePicker.delegate = self
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

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func changeImage(_ sender: Any) {
        let choiceAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "Photo library", style: .default, handler: { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        })
        
        let camera = UIAlertAction(title: "Shoot a photo", style: .default, handler: { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        choiceAlert.addAction(camera)
        choiceAlert.addAction(library)
        choiceAlert.addAction(cancel)
        self.present(choiceAlert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            racerImage.contentMode = .scaleAspectFit
            racerImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
}

extension ProfileViewController {
    
    func configureProfile() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 130
        
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
