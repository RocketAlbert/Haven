//
//  TaskController.swift
//  HavenFirebaseDemo
//
//  Created by Julia Rodriguez on 8/29/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit
import UserNotifications

class TaskController: NSObject {
    
    // singleton
    static let sharedInstance = TaskController()
    
    // source of truth
    var tasks: [Task] = []
    // users current calendar
    var calendar = Calendar.current
    // fill in date from datePicker
    var dateChosen: Date?
    
    // date to display
    var dateToDisplay: String?
    // todays date
    let today = Date()
    
    var dateComponents = DateComponents()
    // initializes as daily
    var currentlySelectedTaskType: TaskIntervalType = .day
    
    
    // Task Types
    func updateSelectedTaskType(to type: TaskIntervalType) {
        // select different cases from enum
        currentlySelectedTaskType = type
    }
    
    func updateDateFromDatePicker(new date: Date) {
        dateChosen = date
    }
    
    func retrievDateFromDatePicker(from date: Date) {
        dateChosen = date
        dateToDisplay = date.stringValue()
    }
    
    // CRUD functions
    
    // Create
    // pass in user components, necessary data to make a task
    func createTask(name: String, date: Date?, intervalFrequency: TaskIntervalType, repeats: Bool) {
        
        let task = Task(uid: UUID().uuidString, taskName: name, home: "default home", createdByUser: "self", dateOfInterval: date, intervalType: intervalFrequency, completedOn: nil, isCompleted: false, repeats: repeats)
        
        tasks.append(task)
        NotificationCenter.default.post(name: Notification.Name("New Task Created"), object: nil)
    }
    // create task from sugguestions
    func createTaskFromSugguestion(name: String, date: Date?, intervalFrequency: TaskIntervalType, repeats: Bool) {
        
        let sugguestedTask = Task(uid: UUID().uuidString, taskName: name, home: "default home", createdByUser: "self", dateOfInterval: date, intervalType: intervalFrequency, completedOn: nil, isCompleted: false, repeats: true)
        tasks.append(sugguestedTask)
    }
    
    // create/send notification
    func sendNotification(title: String, subtitle: String, body: String, badge: Int?, intervalType: TaskIntervalType, date: Date) {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.subtitle = subtitle
        notificationContent.body = body
        notificationContent.badge = 1
        
        // date trigger notifications
        // guard let dateChosen = dateChosen else { return }
        var trigger: UNNotificationTrigger?
        
        switch intervalType {
            
        case .day:
            // get user selected date from date picker
            guard let dailyDate = calendar.date(byAdding: .day, value: 1, to: date) else { return }
            let dailyDateComponents = Calendar.current.dateComponents([.year ,.month, .day, .hour, .minute], from: dailyDate)
            // schedule based on daily interval from datePickerDate
            let dailyTrigger = UNCalendarNotificationTrigger(dateMatching: dailyDateComponents, repeats: true)
            trigger = dailyTrigger
        case .week:
            guard let weeklyDate = calendar.date(byAdding: .day, value: 7, to: date) else { return }
            let weeklyDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: weeklyDate)
            let weeklyTrigger = UNCalendarNotificationTrigger(dateMatching: weeklyDateComponents, repeats: true)
            trigger = weeklyTrigger
        case .month:
            guard let monthlyDate = calendar.date(byAdding: .month, value: 1, to: date) else { return }
            let monthlyDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: monthlyDate)
            let monthlyTrigger = UNCalendarNotificationTrigger(dateMatching: monthlyDateComponents, repeats: true)
            trigger = monthlyTrigger
        case .year:
            guard let yearlyDate = calendar.date(byAdding: .year, value: 1, to: date) else { return }
            let yearlyDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: yearlyDate)
            let yearlyTrigger = UNCalendarNotificationTrigger(dateMatching: yearlyDateComponents, repeats: true)
            trigger = yearlyTrigger
            
        }
        
        if let badge = badge {
            // current badge count
            var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
            // increment
            currentBadgeCount += badge
            // refresh badge count
            notificationContent.badge = NSNumber(integerLiteral: currentBadgeCount)
        }
        notificationContent.sound = UNNotificationSound.default
        
        UNUserNotificationCenter.current().delegate = self
        
        
        let request = UNNotificationRequest(identifier: "testLocalNotification", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // Read
    
    // Update
    
    func updateTask(task: Task, newName: String, dateOfInterval: Date?, newIntervalFrequency: TaskIntervalType) {
        
        task.taskName = newName
        task.dateOfInterval = dateOfInterval
        task.intervalType = newIntervalFrequency
    }
    
    // Delete
    func deleteTask(task: Task) {
        
        // index of the task we are on
        guard let index = tasks.firstIndex(of: task) else { return }
        // from source of truth
        tasks.remove(at: index)
    }
}

extension TaskController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("The notification is about to be presented")
        completionHandler([.badge, .sound, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let identifier = response.actionIdentifier
        
        switch identifier {
        case UNNotificationDismissActionIdentifier:
            print("The notification was dismissed")
            completionHandler()
        case UNNotificationDefaultActionIdentifier:
            print("The user opened the app from the notification")
            completionHandler()
        // dont need to use case
        default:
            print("the default case was called")
            completionHandler()
        }
    }
    
}

