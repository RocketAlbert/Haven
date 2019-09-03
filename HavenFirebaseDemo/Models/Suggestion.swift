//
//  Suggestion.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/22/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import Foundation


class Suggestion {
    var name: String
    var description: String
    var startDate: String
    var repeatOn: String
    
    init(name: String, description: String, startDate: String, repeatOn: String) {
        self.name = name
        self.description = description
        self.startDate = startDate
        self.repeatOn = repeatOn
    }
}
