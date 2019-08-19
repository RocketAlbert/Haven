//
//  SignUpEmailAndPasswordViewController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/13/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class SignUpEmailAndPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override  func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        signUp(email: emailTextField.text, password: passwordTextField.text) { (didAuthorize) in
            print(didAuthorize)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        signUp(email: emailTextField.text, password: passwordTextField.text) { (didAuthorize) in
            if didAuthorize == true {
                textField.resignFirstResponder()
            }
        }
        return true
    }
    
    func signUp(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        guard let unwrappedEmail = email, unwrappedEmail != "", let unwrappedPassword = password, unwrappedPassword != "" else {return}
        FirebaseController.shared.authenticateUser(withEmail: unwrappedEmail, password: unwrappedPassword) { (authenticationDidComplete) in
            print (authenticationDidComplete)
            if authenticationDidComplete == true {
                UserController.shared.createUserUsingFireStore(unwrappedEmail)
                self.performSegue(withIdentifier: "emailToNameOnboardSegue", sender: nil)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


