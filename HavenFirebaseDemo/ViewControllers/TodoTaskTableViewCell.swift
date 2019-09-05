//
//  TodoTaskTableViewCell.swift
//  HavenFirebaseDemo
//
//  Created by Julia Rodriguez on 8/23/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

protocol TaskTodoTableViewCellDelegate {
    func taskItemTapped(_ sender: TodoTaskTableViewCell)
}

class TodoTaskTableViewCell: UITableViewCell {
    

    @IBOutlet weak var isCompleteButton: UIButton!
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var notificationButton: UIButton!
    
    @IBOutlet weak var ellipseButton: UIButton!
    
    // set delegate to protocol name 
    var delegate: TaskTodoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func updateCompleteButton(_ isComplete: Bool) {
        let imageName = isComplete ? "circleChecked" : "completeCircle"
        isCompleteButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        delegate?.taskItemTapped(self)
    }
    
    @IBAction func ellipseButtonTapped(_ sender: Any) {

    }
    
}

extension TodoTaskTableViewCell {
    func update(task: Task) {
        taskLabel.text = task.taskName
       // updateCompleteButton(false)
        task.repeats == true ? notificationButton.setImage(UIImage(named: "bellIcon"), for: .normal) : notificationButton.setImage(UIImage(named: ""), for: .normal)
        updateCompleteButton(task.isCompleted)
    }
}


