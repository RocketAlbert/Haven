//
//  SignUpCreateHomeViewController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/14/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit
import Firebase

class SignUpCreateHomeViewController: UIViewController {
    
    @IBOutlet weak var homeNameTextField: UITextField!
    
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        createNewHomeWithCurrentUser { (didCreate) in
            if didCreate == true {
                // Pop back to root view controller.
                self.popBackToRootNavigationController()
            } else {
                print("error")
            }
        }
    }
    
    // Create a new home from the textfields, grab its dictionary and insert into Firebase. Then append this home to the admin's homes array.
    func createNewHomeWithCurrentUser(completion: @escaping (Bool) -> Void) {
        guard let currentUserUID = UserController.shared.currentUser?.uid else {completion (false); return}
        guard let homeName = homeNameTextField.text, homeName != "", let zipcode = zipcodeTextField.text, zipcode != "" else {completion (false); return}
        
        HomeController.shared.createHomeUsingFireStore(currentUserUID: currentUserUID, name: homeName, zipcode: zipcode) { (houseUID) in
            let userHomeDictionary = ["homes": FieldValue.arrayUnion(["\(houseUID)"])]
            UserController.shared.updateUserFirebebaseFirestore(withUID: currentUserUID, andWithDictionary: userHomeDictionary)
            completion(true)
        }
    }
    
    func popBackToRootNavigationController() {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: {
                self.navigationController!.popToRootViewController(animated: true)
            })
        }
        else {
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
}

