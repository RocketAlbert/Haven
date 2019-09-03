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
    
    // initialized to day
    var taskFrequency = TaskController.sharedInstance.currentlySelectedTaskType

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbackLabel.isHidden = true
        addTaskTextField.delegate = self
        taskTableView.delegate = self
        taskTableView.dataSource = self
        // set initial view as Daily
       // updateToDailyInterval()
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
        dailySelected()
        TaskController.sharedInstance.updateSelectedTaskType(to: .day)
        taskFrequency = .day
        frequencyLabel.text = "Daily"
        addTaskTextField.placeholder = "Add Daily Task..."
    }
    
    func updateToWeeklyInterval() {
        weeklySelected()
        TaskController.sharedInstance.updateSelectedTaskType(to: .week)
        taskFrequency = .week
        frequencyLabel.text = "Weekly"
        addTaskTextField.placeholder = "Add Weekly Task..."
    }
    
    func updateToMonthlyInterval() {
        monthlySelected()
        TaskController.sharedInstance.updateSelectedTaskType(to: .month)
        taskFrequency = .month
        frequencyLabel.text = "Monthly"
        addTaskTextField.placeholder = "Add Monthy Task..."
    }
    func updateToYearlyInterval() {
        yearlySelected()
        TaskController.sharedInstance.updateSelectedTaskType(to: .year)
        taskFrequency = .year
        frequencyLabel.text = "Yearly"
        addTaskTextField.placeholder = "Add Yearly Task..."
    }
    
    func dailySelected() {
        dailyButton.setImage(UIImage(named: "dailySelected"), for: .normal)
        dailyButton.isSelected = true
        weeklyButton.setImage(UIImage(named: "week"), for: .normal)
        weeklyButton.isSelected = false
        monthlyButton.setImage(UIImage(named: "month"), for: .normal)
        monthlyButton.isSelected = false
        yearlyButton.setImage(UIImage(named: "year"), for: .normal)
        yearlyButton.isSelected = false
    }
    
    func weeklySelected() {
        dailyButton.setImage(UIImage(named: "daily"), for: .normal)
        dailyButton.isSelected = false
        weeklyButton.setImage(UIImage(named: "weekSelected"), for: .normal)
        weeklyButton.isSelected = true
        monthlyButton.setImage(UIImage(named: "month"), for: .normal)
        monthlyButton.isSelected = false
        yearlyButton.setImage(UIImage(named: "year"), for: .normal)
        yearlyButton.isSelected = false
    }
    
    func monthlySelected() {
        dailyButton.setImage(UIImage(named: "daily"), for: .normal)
        dailyButton.isSelected = false
        weeklyButton.setImage(UIImage(named: "week"), for: .normal)
        weeklyButton.isSelected = false
        monthlyButton.setImage(UIImage(named: "monthSelected"), for: .normal)
        monthlyButton.isSelected = true
        yearlyButton.setImage(UIImage(named: "year"), for: .normal)
        yearlyButton.isSelected = false
    }
    
    func yearlySelected() {
        dailyButton.setImage(UIImage(named: "daily"), for: .normal)
        dailyButton.isSelected = false
        weeklyButton.setImage(UIImage(named: "week"), for: .normal)
        weeklyButton.isSelected = false
        monthlyButton.setImage(UIImage(named: "month"), for: .normal)
        monthlyButton.isSelected = false
        yearlyButton.setImage(UIImage(named: "yearSelected"), for: .normal)
        yearlyButton.isSelected = true
    }
    
    @IBAction func dailyButtonTapped(_ sender: UIButton) {
        updateToDailyInterval()
        print(taskFrequency)
        taskTableView.reloadData()
    }
    
    @IBAction func weeklyButtonTapped(_ sender: UIButton) {
        updateToWeeklyInterval()
        print(taskFrequency)
        taskTableView.reloadData()
    }
    
    @IBAction func monthlyButtonTapped(_ sender: UIButton) {
        updateToMonthlyInterval()
        print(taskFrequency)
        taskTableView.reloadData()
    }
    
    @IBAction func yearlyButtonTapped(_ sender: UIButton) {
        updateToYearlyInterval()
        print(taskFrequency)
        taskTableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
    }
    
    func taskItemTapped(_ sender: TodoTaskTableViewCell) {
        guard let indexPath = taskTableView.indexPath(for: sender) else { return }
        
        let task = TaskController.sharedInstance.tasks[indexPath.row]
        
    }
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        //performSegue(withIdentifier: "toManageVC", sender: nil)

    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let taskName = addTaskTextField.text else { return }
        
        if segue.identifier == "toAlertVC" {
            
            let newlyMadeTask = Task(uid: UUID().uuidString, taskName: taskName, home: "default home", createdByUser: "self", dateOfInterval: TaskController.sharedInstance.dateChosen, intervalType: taskFrequency, completedOn: nil, isCompleted: false, repeats: false)
            let destinationVC = segue.destination as? AlertViewController
            destinationVC?.taskLandingPad = newlyMadeTask
            print("task frequency is set to: \(taskFrequency)")
            
        }
        if segue.identifier == "toManageVC" {
             // object to send
            let newlyMadeTask = Task(uid: UUID().uuidString, taskName: taskName, home: "default home", createdByUser: "self", dateOfInterval: TaskController.sharedInstance.dateChosen, intervalType: taskFrequency, completedOn: nil, isCompleted: false, repeats: false)
            
            // destination
            let destinationVC = segue.destination as? ManageTaskTableViewController
           
            // object to set (landing pad)
            destinationVC?.taskLandingPad = newlyMadeTask
            print("task frequency is set to: \(taskFrequency)")

        }
        addTaskTextField.text = ""
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // switch between different buttons selected
        switch taskFrequency {
        case .day:
            let dayTasks = TaskController.sharedInstance.tasks.filter { $0.intervalType == .day }
            return dayTasks.count
        case .week:
            let weekTasks = TaskController.sharedInstance.tasks.filter { $0.intervalType == .week}
            return weekTasks.count
        case .month:
            let monthTasks = TaskController.sharedInstance.tasks.filter { $0.intervalType == .month}
            return monthTasks.count
        case .year:
            let yearTasks = TaskController.sharedInstance.tasks.filter { $0.intervalType == .year}
            return yearTasks.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TodoTaskTableViewCell else { return UITableViewCell() }
        switch taskFrequency {
        case .day:
            let dayTasks = TaskController.sharedInstance.tasks.filter { $0.intervalType == .day }[indexPath.row]
            //let dayTasks = taskItem[indexPath.row]
            cell.update(task: dayTasks)
            cell.delegate = self
            return cell
        case .week:
            let weekTasks = TaskController.sharedInstance.tasks.filter {$0.intervalType == .week}[indexPath.row]
            cell.update(task: weekTasks)
            cell.delegate = self
            return cell
        case .month:
            let monthTasks = TaskController.sharedInstance.tasks.filter {$0.intervalType == .month}[indexPath.row]
            cell.update(task: monthTasks)
            cell.delegate = self
            return cell
        case .year:
            let yearTasks = TaskController.sharedInstance.tasks.filter {$0.intervalType == .year}[indexPath.row]
            cell.update(task: yearTasks)
            cell.delegate = self
            return cell
        }
        
    /*
        let taskItem = TaskController.sharedInstance.tasks[indexPath.row]
        cell.update(task: taskItem)
        cell.delegate = self
        return cell
        */
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let completeAction = UIContextualAction(style: .destructive, title: "Complete") { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
        }
        completeAction.backgroundColor = UIColor(named: "aquaGreen")
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Remove") { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
        }
        removeAction.backgroundColor = .gray
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentAddSwipeAlert()
    }
    
    func presentAddSwipeAlert() {
        
        let alertController = UIAlertController(title: "Swipe Capabilities", message: "Swipe Left to Remove Task & Swipe Right to Mark as Complete ", preferredStyle: .alert)
        
        
        // Action: Add
        let addOkAction = UIAlertAction(title: "Got it!", style: .cancel)
    
        // Action: Cancel
        //let cancelAction = UIAlertAction(title:"Cancel", style: .cancel)
        
        // implement actions to Main Alert Controller
        alertController.addAction(addOkAction)
        // Display the final alert pop-up
        self.present(alertController, animated: true)
    }
    
}

extension TodoListViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .yes
        textField.adjustsFontForContentSizeCategory = true
        //textField.adjustsFontSizeToFitWidth = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        textField.resignFirstResponder()
        //taskTableView.reloadData()
        
        // TODO: make a show pop up view controller func
        performSegue(withIdentifier: "toAlertVC", sender: nil)
        
        return true
    }
    
}
