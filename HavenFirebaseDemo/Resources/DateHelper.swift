//
//  DateHelper.swift
//  HavenFirebaseDemo
//
//  Created by Julia Rodriguez on 8/27/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import Foundation

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.dateFormat = "MMM d, h:mm a"

        
        return formatter.string(from: self)
    }
}
