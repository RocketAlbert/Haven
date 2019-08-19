//
//  SignUpNameViewController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/13/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class SignUpNameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signUpNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpNameTextField.delegate = self
    }
    
    @IBAction func nameNextButtonTapped(_ sender: Any) {
        editNameOnboard(name: signUpNameTextField.text) { (nameSaveDidComplete) in
            print(nameSaveDidComplete)
            if nameSaveDidComplete == true {
                self.performSegue(withIdentifier: "nameToChoiceOnboardSegue", sender: nil)
            } else {
                print("error")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        editNameOnboard(name: signUpNameTextField.text) { (nameSaveDidComplete) in
            if nameSaveDidComplete == true {
                self.performSegue(withIdentifier: "nameToChoiceOnboardSegue", sender: nil)
                textField.resignFirstResponder()
            } else {
                print("error")
            }
        }
        return true
    }
    
    func editNameOnboard(name: String?, completion: @escaping (Bool)-> Void) {
        guard let unwrappedName = name, name != "" else {return}
        let path = "users/\(FirebaseController.shared.currentUser!.uid)"
        let userDictionary = ["name": unwrappedName]
        FirebaseController.shared.updateDocumentFirebaseFirestore(withPath: path, andWithDictionary: userDictionary) { (didCompleteNameSave) in
            print(didCompleteNameSave)
            completion(didCompleteNameSave)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
