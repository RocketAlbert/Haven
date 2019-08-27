//
//  NotificationsViewController.swift
//  HavenFirebaseDemo
//
//  Created by Julia Rodriguez on 8/20/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class NotificationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func subscribeToNotificationTopic() {
        Messaging.messaging().subscribe(toTopic: "weather") {
            error in
            print("Subscribed to weather topic")
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
