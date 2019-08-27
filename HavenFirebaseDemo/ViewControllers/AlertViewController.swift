//
//  AlertViewController.swift
//  HavenFirebaseDemo
//
//  Created by Julia Rodriguez on 8/23/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func datePickerTapped(_ sender: UIDatePicker) {
    }
    
    @IBAction func addAlertButtonTapped(_ sender: UIButton) {
        let date = datePicker.date
        dismiss(animated: true)
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
