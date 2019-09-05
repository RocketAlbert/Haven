//
//  ManageTaskTableViewController.swift
//  HavenFirebaseDemo
//
//  Created by Julia Rodriguez on 8/26/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class ManageTaskTableViewController: UITableViewController {
    
    var taskLandingPad: Task?
    
    let checkedImage = UIImage(named: "checkmark")
    var dailyToggle = false
    var weeklyToggle = false
    var monthlyToggle = false
    var yearlyToggle = false
    // set defaut interval to daily 
    //var currentlySelectedTaskType: TaskIntervalType = .day
    var dateToDisplay : String?
    var dateForNotification: Date?
    
    @IBOutlet weak var editTaskLabel: UITextField!
    @IBOutlet weak var taskFrequencyLabel: UILabel!
    @IBOutlet weak var intervalSelectedLabel: UILabel!
    @IBOutlet weak var taskFrequencyToggle: UISwitch!
    @IBOutlet weak var frequencyStackView: UIStackView!
    
    @IBOutlet weak var dailyButton: UIButton!
    @IBOutlet weak var dailyCheck: UIImageView!
    
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var weeklyCheck: UIImageView!
    
    @IBOutlet weak var monthlyButton: UIButton!
    @IBOutlet weak var monthlyCheck: UIImageView!
    
    @IBOutlet weak var yearlyButton: UIButton!
    @IBOutlet weak var yearlyCheck: UIImageView!
    
    @IBOutlet weak var taskFrequencyDoneButton: UIButton!
    
    @IBOutlet weak var notifyMeLabel: UILabel!
    @IBOutlet weak var notifyDateLabel: UILabel!
    @IBOutlet weak var notifyToggle: UISwitch!
    @IBOutlet weak var notifyDatePicker: UIDatePicker!
    @IBOutlet weak var notifyDoneButton: UIButton!
    
    @IBOutlet weak var removeIntervalButton: UIButton!
    var showTaskInterval: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
    var showNotifyDate: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Manage Task"
        navigationItem.largeTitleDisplayMode = .always
//        editTaskLabel.delegate = self
        hideTaskFrequency()
        hideDatePicker()
        updateViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
    }
    
    @IBAction func taskFrequencyToggle(_ sender: UISwitch) {
        if taskFrequencyToggle.isOn {
            showTaskInterval = true
            showNotifyDate = false
        }
        
        UIView.animate(withDuration: 1.9) {
            if self.taskFrequencyToggle.isOn == true {
                self.showTaskFrequency()
            }
           else if self.taskFrequencyToggle.isOn == false {
                self.showTaskInterval = false
                self.hideTaskFrequency()
            }
        }
    }
    
    func hideTaskFrequency() {
        taskFrequencyDoneButton.isHidden = true
        frequencyStackView.isHidden = true
    }
    func showTaskFrequency() {
        taskFrequencyDoneButton.isHidden = false
        frequencyStackView.isHidden = false
    }
    
    @IBAction func taskFrequencyDoneButtonTapped(_ sender: UIButton) {
        hideTaskFrequency()
        showTaskInterval = false
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            showTaskInterval = true
            showTaskFrequency()
            showNotifyDate = false
            hideDatePicker()
        }
        if indexPath.row == 3 {
            showNotifyDate = true
            showDatePicker()
            showTaskInterval = false
            hideTaskFrequency()
        }
    }
    
    func updateViews() {
        
        // unwrap object to verify there is content
        guard let task = taskLandingPad else { return }
        
        editTaskLabel.text = task.taskName
        
        switch task.intervalType {
        case .day:
            intervalSelectedLabel.text = "Daily"
            displayDailyChecked()
        removeIntervalButton.setImage(UIImage(named: "removeDaily"), for: .normal)
        case .week:
            intervalSelectedLabel.text = "Weekly"
            displayWeeklyChecked()
        removeIntervalButton.setImage(UIImage(named: "removeWeekly"), for: .normal)
        case .month:
            intervalSelectedLabel.text = "Monthly"
            displayMonthlyChecked()
        removeIntervalButton.setImage(UIImage(named: "removeMonthly"), for: .normal)
        case .year:
            intervalSelectedLabel.text = "Yearly"
            displayYearlyChecked()
        removeIntervalButton.setImage(UIImage(named: "removeYearly"), for: .normal
            )
        }
        
        if task.repeats == true {
            notifyToggle.isOn = true
            notifyDateLabel.text = task.dateOfInterval?.stringValue()
        } else if task.repeats == false {
            notifyToggle.isOn = false
            notifyDateLabel.text = "Currently turned off"

        }
        
        //intervalSelectedLabel.text = task.intervalType.rawValue
        
        // update date picker value
        if let date = task.dateOfInterval {
            notifyDatePicker.date = date
        }
    }
   
    
    @IBAction func notifyToggle(_ sender: UISwitch) {
    
        UIView.animate(withDuration: 1.5) {
            if self.notifyToggle.isOn == true {
                self.notifyDateLabel.text = "Select Date Below"
                self.showNotifyDate = true
                self.showDatePicker()
                self.taskLandingPad?.repeats = true
            } else if self.notifyToggle.isOn == false {
                self.showNotifyDate = false
                self.hideDatePicker()
                self.taskLandingPad?.repeats = false
                self.notifyDateLabel.text = "Currently turned off"
            }
        }
    }
    
    
    @IBAction func notifyDoneButtonTapped(_ sender: Any) {
        notifyDateLabel.text = dateToDisplay
        hideDatePicker()
        showNotifyDate = false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
         // TODO: make it dynamic of the screen size, view.height / # = fraction of screen height, self.view.frame.height
        switch indexPath.row {
        case 0:
            return 50
        case 1:
            return 54
        case 2:
            if showTaskInterval == false {
                return 0
            }
            return 179
        case 3:
            return 54
        case 4:
            if showNotifyDate == false {
                return 0
            }
            return 247
        case 5:
            return 44
        default:
            return 44
        }
    }
    
    
    func hideDatePicker() {
        notifyDatePicker.isHidden = true
        notifyDoneButton.isHidden = true
        //tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
    }
    
    func showDatePicker() {
        self.notifyDatePicker.isHidden = false
        self.notifyDoneButton.isHidden = false
    }
    
    @IBAction func notifyDatePickerChanged(_ sender: UIDatePicker) {
        dateToDisplay = sender.date.stringValue()
        dateForNotification = notifyDatePicker.date
        TaskController.sharedInstance.dateChosen = notifyDatePicker.date
       // let monthComponent = Calendar.current.component(.hour, from: dateForNotification)
        
    }
    
    @IBAction func removeTaskButtonTapped(_ sender: UIButton) {
        guard let task = taskLandingPad else { return }
        // delete task from source of truth
        TaskController.sharedInstance.deleteTask(task: task)
        // remove pending notifications
        TaskController.sharedInstance.removeNotification(body: task.taskName)
        // TODO: verify tableview is reloaded, on view will appear
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func taskDoneButtonTapped(_ sender: UIButton) {
        // unwrap object
        guard let task = taskLandingPad else { return }
        
        guard let newTask = editTaskLabel.text else { return }
        var repeats: Bool = false
        
        if notifyToggle.isOn == true {
            repeats = true
        } else if notifyToggle.isOn == false {
            repeats = false
        }
    
        TaskController.sharedInstance.updateTask(task: task, newName: newTask, dateOfInterval: notifyDatePicker.date, newIntervalFrequency: task.intervalType, repeats: repeats)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func displayDailyChecked() {
        dailyCheck.image = checkedImage
        weeklyCheck.image = nil
        monthlyCheck.image = nil
        yearlyCheck.image = nil
    }
    
    func displayWeeklyChecked() {
        dailyCheck.image = nil
        weeklyCheck.image = checkedImage
        monthlyCheck.image = nil
        yearlyCheck.image = nil
    }
    
    func displayMonthlyChecked() {
        dailyCheck.image = nil
        weeklyCheck.image = nil
        monthlyCheck.image = checkedImage
        yearlyCheck.image = nil
    }
    
    func displayYearlyChecked() {
        dailyCheck.image = nil
        weeklyCheck.image = nil
        monthlyCheck.image = nil
        yearlyCheck.image = checkedImage
    }
    
    
    @IBAction func dailyFrequencyTapped(_ sender: UIButton) {
        if dailyToggle == false {
            displayDailyChecked()
            intervalSelectedLabel.text = "Daily"
            dailyToggle = true
            taskLandingPad?.intervalType = .day
            
        } else if dailyToggle == true {
            dailyCheck.image = nil
            intervalSelectedLabel.text = nil
            dailyToggle = false
        }
    }
    
    @IBAction func weeklyFrequencyTapped(_ sender: UIButton) {
        if weeklyToggle == false {
            displayWeeklyChecked()
            intervalSelectedLabel.text = "Weekly"
            weeklyToggle = true
            taskLandingPad?.intervalType = .week
        } else if weeklyToggle == true {
            weeklyCheck.image = nil
            intervalSelectedLabel.text = nil
            weeklyToggle = false
        }
    }
    @IBAction func monthlyButtonTapped(_ sender: UIButton) {
        if monthlyToggle == false {
            displayMonthlyChecked()
            intervalSelectedLabel.text = "Monthly"
            monthlyToggle = true
            taskLandingPad?.intervalType = .month
        } else if monthlyToggle == true {
            monthlyCheck.image = nil
            intervalSelectedLabel.text = nil
            monthlyToggle = false
        }
    }
    @IBAction func yearlyButtonTapped(_ sender: UIButton) {
        if yearlyToggle == false {
            displayYearlyChecked()
            intervalSelectedLabel.text = "Yearly"
            yearlyToggle = true
            taskLandingPad?.intervalType = .year
        } else if yearlyToggle == true {
            yearlyCheck.image = nil
            intervalSelectedLabel.text = nil
            yearlyToggle = false
        }
        
    }

}

extension ManageTaskTableViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .yes
        textField.adjustsFontSizeToFitWidth = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let editedTask = textField.text {
            TodoListController.sharedInstance.addTask(chore: editedTask)
            
            print(editedTask)
        }
        textField.resignFirstResponder()
        
        return true
    }
}
