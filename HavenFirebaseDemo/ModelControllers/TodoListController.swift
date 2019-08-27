//
//  TodoListController.swift
//  HavenFirebaseDemo
//
//  Created by Julia Rodriguez on 8/23/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import Foundation

class TodoListController {
    
    // singleton
    static let sharedInstance = TodoListController()
    
    var todoList: [String] = ["Take out the garbage", "Mow the lawn", "Clean the bathroom", "Sweep the floor", "Vacuum the carpet"]
    
    func addTask(chore: String) {
        
        let newTask = chore
        todoList.append(newTask)
    }
    
    func toggleIsCompleteFor(chore: String) {
        
    }
}


