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
        
        racerImage.image = loadImageFromPath(path: "profilo.png")
        loadStrings()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let defaults: UserDefaults = UserDefaults.standard
        
        defaults.set(racerNumber.text, forKey: "number")
        defaults.set(racerName.text, forKey: "name")
        defaults.set(racerSurname.text, forKey: "surname")
        defaults.set(favouriteCar.text, forKey: "favouriteCar")
        defaults.set(otherCar.text, forKey: "otherCar")
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
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell") as! ProfileTableViewCell
        cell.configure(index: indexPath)
        
        return cell
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func changeImage(_ sender: Any) {
        let choiceAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "Galleria foto", style: .default, handler: { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        })
        
        let camera = UIAlertAction(title: "Scatta una foto", style: .default, handler: { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true)
        })
        
        let cancel = UIAlertAction(title: "Annulla", style: .cancel)
        
        choiceAlert.addAction(camera)
        choiceAlert.addAction(library)
        choiceAlert.addAction(cancel)
        self.present(choiceAlert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            racerImage.contentMode = .scaleAspectFit
            racerImage.image = pickedImage
            print(getDocumentsURL(filename: "profilo.png"))
            saveImage(image: pickedImage, path: getDocumentsURL(filename: "profilo.png"))
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

// MARK: Settaggio Placeholder e rowheight

extension ProfileViewController {
    
    func configureProfile() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 130
        
        racerNumber.attributedPlaceholder = NSAttributedString(string: "Numero di gara", attributes: [NSForegroundColorAttributeName: placeholderGrey])
        racerName.attributedPlaceholder = NSAttributedString(string: "Nome", attributes: [NSForegroundColorAttributeName: placeholderGrey])
        racerSurname.attributedPlaceholder = NSAttributedString(string: "Cognome", attributes: [NSForegroundColorAttributeName: placeholderGrey])
        favouriteCar.attributedPlaceholder = NSAttributedString(string: "Auto preferita", attributes: [NSForegroundColorAttributeName: placeholderGrey])
        otherCar.attributedPlaceholder = NSAttributedString(string: "Altra auto", attributes: [NSForegroundColorAttributeName: placeholderGrey])
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

// MARK: Caricamento/Salvataggio dati

extension ProfileViewController {
    
    func getDocumentsURL(filename: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(filename)
        return fileURL
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        let file = getDocumentsURL(filename: path).path
        print("\necco il file " + file)
        var image = UIImage(contentsOfFile: file)
        
        if image == nil {
            print("missing image at: \(path)")
            image = UIImage(named: "pilota-con-fotocamera.png")
        }
        return image
    }
    
    func saveImage (image: UIImage, path: URL ) {
        let pngImageData = UIImagePNGRepresentation(image)!
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        try! pngImageData.write(to: path)
    }
    
    func loadStrings() {
        let defaults: UserDefaults = UserDefaults.standard

        if let number = defaults.string(forKey: "number") {
            racerNumber.text = number
        }
        if let name = defaults.string(forKey: "name") {
            racerName.text = name
        }
        if let surname = defaults.string(forKey: "surname") {
            racerSurname.text = surname
        }
        if let favCar = defaults.string(forKey: "favouriteCar") {
            favouriteCar.text = favCar
        }
        if let other = defaults.string(forKey: "otherCar") {
            otherCar.text = other
        }
    }
}
