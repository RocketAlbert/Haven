//
//  TodoListViewController.swift
//  HavenFirebaseDemo
//
//  Created by Julia Rodriguez on 8/23/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController, TaskTodoTableViewDelegate {
    
    @IBOutlet weak var dailyButton: UIButton!
    
    @IBOutlet weak var weeklyButton: UIButton!
    
    @IBOutlet weak var monthlyButton: UIButton!
    
    @IBOutlet weak var yearlyButton: UIButton!
    
    @IBOutlet weak var frequencyLabel: UILabel!
    
    @IBOutlet weak var statusFractionLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var addTaskButton: UIButton!
    
    @IBOutlet weak var addTaskTextField: UITextField!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var taskTableView: UITableView!
    
    let taskFrequency = TaskController.sharedInstance.currentlySelectedTaskType

    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackLabel.isHidden = true
        addTaskTextField.delegate = self
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        // add observer so that the tableview knows when to reload
        NotificationCenter.default.addObserver(forName: Notification.Name("New Task Created"), object: nil, queue: nil) { (_) in
            self.taskTableView.reloadData()
        }
        
        switch taskFrequency {
        case .day:
            updateToDailyInterval()
        case .week:
            updateToWeeklyInterval()
        case .month:
            updateToMonthlyInterval()
        case .year:
            updateToYearlyInterval()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.taskTableView.reloadData()
        }
    }
    
    // de-initialize
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
    }
    
    func updateToDailyInterval() {
        dailyButton.isSelected = true
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yearlyButton.isSelected = false
        TaskController.sharedInstance.updateSelectedTaskType(to: .day)
        frequencyLabel.text = "Daily"
        addTaskTextField.placeholder = "Add Daily Task..."
    }
    
    func updateToWeeklyInterval() {
        dailyButton.isSelected = false
        weeklyButton.isSelected = true
        monthlyButton.isSelected = false
        yearlyButton.isSelected = false
        TaskController.sharedInstance.updateSelectedTaskType(to: .week)
        frequencyLabel.text = "Weekly"
        addTaskTextField.placeholder = "Add Weekly Task..."
    }
    
    func updateToMonthlyInterval() {
        dailyButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = true
        yearlyButton.isSelected = false
        TaskController.sharedInstance.updateSelectedTaskType(to: .month)
        frequencyLabel.text = "Monthly"
        addTaskTextField.placeholder = "Add Monthy Task..."
    }
    func updateToYearlyInterval() {
        dailyButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yearlyButton.isSelected = true
        TaskController.sharedInstance.updateSelectedTaskType(to: .year)
        frequencyLabel.text = "Yearly"
        addTaskTextField.placeholder = "Add Yearly Task..."
    }
    
    @IBAction func dailyButtonTapped(_ sender: UIButton) {
        updateToDailyInterval()
    }
    
    @IBAction func weeklyButtonTapped(_ sender: UIButton) {
        updateToWeeklyInterval()
    }
    
    @IBAction func monthlyButtonTapped(_ sender: UIButton) {
        updateToMonthlyInterval()
    }
    
    @IBAction func yearlyButtonTapped(_ sender: UIButton) {
        updateToYearlyInterval()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
    }
    
    func taskItemTapped(_ sender: TodoTaskTableViewCell) {
        guard let indexPath = taskTableView.indexPath(for: sender) else { return }
        
        let task = TaskController.sharedInstance.tasks[indexPath.row]
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let taskName = addTaskTextField.text else { return }
        
        if segue.identifier == "toAlertVC" {
            let newlyMadeTask = Task(uid: UUID().uuidString, taskName: taskName, home: "default home", createdByUser: "self", dateOfInterval: nil, intervalType: TaskController.sharedInstance.currentlySelectedTaskType, completedOn: nil, isCompleted: false, repeats: false)
            let destinationVC = segue.destination as? AlertViewController
            destinationVC?.taskLandingPad = newlyMadeTask
            
        }
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedInstance.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TodoTaskTableViewCell else { return UITableViewCell() }
        let taskItem = TaskController.sharedInstance.tasks[indexPath.row]
        cell.update(task: taskItem)
        cell.delegate = self
        return cell
    }
}

extension TodoListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        //taskTableView.reloadData()
        
        // TODO: make a show pop up view controller func
        performSegue(withIdentifier: "toAlertVC", sender: nil)
        
        return true
    }
    
}
