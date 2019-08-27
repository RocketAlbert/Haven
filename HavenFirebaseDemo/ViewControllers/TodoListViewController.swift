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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackLabel.isHidden = true
        addTaskTextField.delegate = self
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
    
    
    @IBAction func dailyButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func weeklyButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func monthlyButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func yearlyButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
    }
    func taskItemTapped(_ sender: TodoTaskTableViewCell) {
        guard let indexPath = taskTableView.indexPath(for: sender) else { return }
        
        let task = TodoListController.sharedInstance.todoList[indexPath.row]
        

    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoListController.sharedInstance.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TodoTaskTableViewCell else { return UITableViewCell() }
        let taskItem = TodoListController.sharedInstance.todoList[indexPath.row]
        
        cell.update(task: taskItem)
        cell.delegate = self
        return cell
    }
}

extension TodoListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let newTask = addTaskTextField.text {
            TodoListController.sharedInstance.addTask(chore: newTask)
        }
        textField.resignFirstResponder()
        taskTableView.reloadData()
        textField.text = ""
        
        // TODO: make a show pop up view controller func
        performSegue(withIdentifier: "toAlertVC", sender: nil)
        
        return true
    }
    
}
