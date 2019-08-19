//
//  SignUpCreateHomeFindHomeChoiceViewController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/13/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class SignUpCreateHomeFindHomeChoiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func skipForNowButtonTapped(_ sender: Any) {
        popToRootNavigationController()
    }
    
    @IBAction func createHomeButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "createHomeOnboardSegue", sender: nil)
    }
    
    @IBAction func findHomeButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "findAHomeOnboardSegue", sender: nil)
    }
    
    func popToRootNavigationController() {
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
