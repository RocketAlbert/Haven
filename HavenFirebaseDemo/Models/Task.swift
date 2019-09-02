//
//  Home.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/12/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//



import Foundation

class Task {
    var uid: String?
    var taskName: String
    var home: String
    //    var assignedTo: String?
    //    var assignedBy: String?
    var createdByUser: String
    var datesToBeCompleted: String
    var intervalType: TaskIntervalType
    var completedOn: Date?
    var isCompleted: Bool
    var repeats: Bool
    
    enum TaskIntervalType: String {
        
        case day
        case week
        case month
        case year
    }
    
    init(uid: String, taskName: String, home: String, createdByUser: String, datesToBeCompleted: String, intervalType: TaskIntervalType, completedOn: Date?, isCompleted: Bool, repeats: Bool) {
        self.uid = uid
        self.taskName = taskName
        self.home = home
        //        self.assignedTo = assignedTo
        //        self.assignedBy = assignedBy
        self.createdByUser = createdByUser
        self.datesToBeCompleted = datesToBeCompleted
        self.intervalType = intervalType
        self.completedOn = completedOn
        self.isCompleted = isCompleted
        self.repeats = repeats
    }
    
    var dictionary: [String : Any] {
        return [
            TaskConstants.uidKey: self.uid ?? "",
            TaskConstants.taskNameKey: self.taskName,
            TaskConstants.homeKey: self.home,
            //            TaskConstants.assignedByKey: self.assignedBy ?? "",
            //            TaskConstants.assignedToKey: self.assignedTo ?? "",
            TaskConstants.createdByUserKey: self.createdByUser,
            TaskConstants.intervalTypeKey: self.intervalType.rawValue,
            TaskConstants.completeOnKey: self.completedOn,
            TaskConstants.datesToBeCompletedKey: self.datesToBeCompleted,
            TaskConstants.isCompletedKey: self.isCompleted,
            TaskConstants.repeatsKey: self.repeats
        ]
    }
}

// Slam dunk recieving from an entire dictionary
extension Task {
    convenience init?(dictionary: [String : Any]) {
        guard let uid = dictionary[TaskConstants.uidKey] as? String,
            let taskName = dictionary[TaskConstants.taskNameKey] as? String,
            let home = dictionary[TaskConstants.homeKey] as? String,
            let createdByUser = dictionary[TaskConstants.createdByUserKey] as? String,
            let intervalTypeAsString = dictionary[TaskConstants.intervalTypeKey] as? String,
            let intervalType = TaskIntervalType(rawValue: intervalTypeAsString),
            let completedOn = dictionary[TaskConstants.completeOnKey] as? Date,
            let datesToBeCompleted = dictionary[TaskConstants.datesToBeCompletedKey] as? String,
            let repeats = dictionary[TaskConstants.repeatsKey] as? Bool,
            let isCompleted = dictionary[TaskConstants.isCompletedKey] as? Bool else {return nil}
        
        self.init(uid: uid, taskName: taskName, home: home, createdByUser: createdByUser, datesToBeCompleted: datesToBeCompleted, intervalType: intervalType, completedOn: completedOn, isCompleted: isCompleted, repeats: repeats)
    }
}

//extension Task {
//    convenience init?(uid: String) {
//        self.init(uid: uid, taskName: "", home: "", createdByUser: "", datesToBeCompleted: "", completedOn: nil, isCompleted: false)
//    }
//}

// Conform to equatable.
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.uid == rhs.uid
    }
}

struct TaskConstants {
    static let typeKey = "Task"
    fileprivate static let uidKey = "uid"
    fileprivate static let taskNameKey = "taskName"
    fileprivate static let homeKey = "home"
    fileprivate static let createdByUserKey = "createdByUser"
    fileprivate static let intervalTypeKey = "intervalType"
    fileprivate static let completeOnKey = "completedOn"
    fileprivate static let datesToBeCompletedKey = "datesToBeCompleted"
    fileprivate static let isCompletedKey = "isCompleted"
    fileprivate static let repeatsKey = "repeats"
}
