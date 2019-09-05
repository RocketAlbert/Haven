//
//  AlertViewController.swift
//  HavenFirebaseDemo
//
//  Created by Julia Rodriguez on 8/23/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
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
        var frequency: String = ""
        
        switch task.intervalType {
        case .day:
            frequency = "Daily"
        case .week:
            frequency = "Weekly"
        case .month:
            frequency = "Monthly"
        case .year:
            frequency = "Yearly"
        }
        
        TaskController.sharedInstance.createTask(name: task.taskName, date: datePicker.date, intervalFrequency: task.intervalType, repeats: true)
        
        TaskController.sharedInstance.sendNotification(title: "\(frequency) - Home Maintenance", subtitle: "", body: task.taskName, badge: 1, intervalType: task.intervalType, date: datePicker.date)
        NotificationCenter.default.post(name: Notification.Name("Notification Created"), object: nil)
        dismiss(animated: true)
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        guard let task = taskLandingPad else { return }
        TaskController.sharedInstance.createTask(name: task.taskName, date: nil, intervalFrequency: task.intervalType, repeats: false)
        dismiss(animated: true)
    }
    
}
