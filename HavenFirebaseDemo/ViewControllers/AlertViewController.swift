//
//  AlertViewController.swift
//  HavenFirebaseDemo
//
//  Created by Julia Rodriguez on 8/23/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    // landing pad from TodoListViewController
    var taskLandingPad: Task?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func datePickerTapped(_ sender: UIDatePicker) {
        TaskController.sharedInstance.dateChosen = datePicker.date
    }
    
    @IBAction func addAlertButtonTapped(_ sender: UIButton) {
        guard let task = taskLandingPad else { return }
        
        task.dateOfInterval = datePicker.date
        // TODO: createTask from sharedInstance
        TaskController.sharedInstance.createTask(name: task.taskName, date: datePicker.date, intervalFrequency: task.intervalType, repeats: true)
        dismiss(animated: true)
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        guard let task = taskLandingPad else { return }
        TaskController.sharedInstance.createTask(name: task.taskName, date: nil, intervalFrequency: task.intervalType, repeats: false)
        dismiss(animated: true)
    }
    
}
