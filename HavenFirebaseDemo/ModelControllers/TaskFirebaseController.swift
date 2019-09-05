//
//  TaskFirebaseController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/30/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import Foundation

class TaskFirebaseController {
    static let shared = TaskFirebaseController()
    
    func createNewTaskUsingFirebase(homeID: String, dictionary: [String:Any]) {
        let path = "tasks"
        FirebaseController.shared.saveToFirebaseFirestoreAndGenerateUID(withPath: path, andWithDictionary: dictionary) { (documentUID) in
            print(documentUID )
        }
    }
    
    
    // Fetches all the tasks for a selected home.
    func fetchAllTasksForHome (homeUID: String, completion: @escaping([Task]) -> Void) {
        FirebaseController.shared.fetchDictionaryFirebaseFireStore(collectionPath: "task", type: "homeUID", searchTerm: "\(homeUID)") { (taskSnapshots) in
            // Should only return one task.
            var fetchedTasks: [Task] = []
            for task in taskSnapshots {
                if let searchedTask = Task(dictionary: task.data()) {
                    searchedTask.uid = task.documentID
                    fetchedTasks.append(searchedTask)} else {
                    completion(fetchedTasks)
                }
            }
            completion(fetchedTasks)
        }
    }
    
    func removeTaskFromFirebase (taskToDeleteUID: String) {
        let path = "tasks/\(taskToDeleteUID)"
        FirebaseController.shared.removeDocumentFirebaseFirestore(withPath: path) { (didComplete) in
            print(didComplete)
        }
    }
    
    // Will be called anything is changed.
    // Will be called also called if notfications are toggled on and off.
    func updateTaskUsingFirebase (taskUID: String, dictionary: [String: Any]) {
        let path = "task/\(taskUID)"
        FirebaseController.shared.updateDocumentFirebaseFirestore(withPath: path, andWithDictionary: dictionary) { (didUpdate) in
            print(didUpdate)
        }
    }
    
    func fetchTaskFromFirebase (taskUID: String, completion: @escaping(Task) -> Void) {
        FirebaseController.shared.fetchDictionaryFirebaseFireStore(collectionPath: "task", type: "uid", searchTerm: "\(taskUID)") { (taskSnapshots) in
            var fetchedTasks: [Task] = []
            for task in taskSnapshots {
                if let searchedTask = Task(dictionary: task.data()) {
                    searchedTask.uid = task.documentID
                    fetchedTasks.append(searchedTask)} else {
                    completion(fetchedTasks[0])
                }
            }
            completion(fetchedTasks[0])
        }
    }
}
