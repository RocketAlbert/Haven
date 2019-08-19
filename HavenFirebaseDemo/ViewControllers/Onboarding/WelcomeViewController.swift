//
//  WelcomeViewController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/14/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
