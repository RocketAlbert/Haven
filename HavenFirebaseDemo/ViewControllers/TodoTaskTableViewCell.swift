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
    
    func ellipseButtonTapped(_ sender: TodoTaskTableViewCell)
}

class TodoTaskTableViewCell: UITableViewCell {
    

    @IBOutlet weak var isCompleteButton: UIButton!
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var notificationButton: UIButton!
    
    @IBOutlet weak var ellipseButton: UIButton!
    
    // set delegate to protocol name 
    var delegate: TaskTodoTableViewCellDelegate?
    // landing pad
    var task: Task?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func updateCompleteButton(_ isComplete: Bool) {
        let imageName = isComplete ? "circleChecked" : "completeCircle"
        isCompleteButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        // TODO: update button state
        delegate?.taskItemTapped(self)
    }
    
    @IBAction func ellipseButtonTapped(_ sender: Any) {
        delegate?.ellipseButtonTapped(self)
    }
    
}

extension TodoTaskTableViewCell {
    func update() {
        // unwraps the landing pad / object 
        guard let task = task else { return }
        taskLabel.text = task.taskName
       // updateCompleteButton(false)
        task.repeats == true ? notificationButton.setImage(UIImage(named: "bellIcon"), for: .normal) : notificationButton.setImage(UIImage(named: ""), for: .normal)
        updateCompleteButton(task.isCompleted)
    }
}


