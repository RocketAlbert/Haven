//
//  HomeScreenViewController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/14/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        // Checks if there is a current user before screen is started. Segues to onboard flow.
        if FirebaseController.shared.currentUser?.uid == nil {
            performSegue(withIdentifier: "signOutToOnboardSegue", sender: nil)
        }
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        FirebaseController.shared.signOut()
        performSegue(withIdentifier: "signOutToOnboardSegue", sender: nil)
    }
}
