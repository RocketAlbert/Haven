//
//  OnboardNavigationViewController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/17/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class OnboardNavigationViewController: UINavigationController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if FirebaseController.shared.currentUser?.uid != nil {
            performSegue(withIdentifier: "navigationControllerToMainSegue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
