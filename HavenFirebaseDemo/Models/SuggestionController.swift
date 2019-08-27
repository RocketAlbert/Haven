//
//  RecommendationsData.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/22/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import Foundation

class SuggestionController {
    
    static let shared = SuggestionController()
    
    var general: [Suggestion] {
        let general1 = Suggestion(name: "Mow the Lawn", description: "Chop em' down", startDate: "00/22/44", repeatOn: "week")
        let general2 = Suggestion(name: "Mow the Lawn", description: "Chop em' down", startDate: "00/22/44", repeatOn: "week")
        let general3 = Suggestion(name: "Mow the Lawn", description: "Chop em' down", startDate: "00/22/44", repeatOn: "week")
        return [general1, general2, general3]
    }
    var winter: [Suggestion] {
        let winter1 = Suggestion(name: "Shovel The Driveway", description: "You might need a shovel", startDate: "00/22/44", repeatOn: "day")
        let winter2 = Suggestion(name: "Shovel The Driveway", description: "You might need a shovel", startDate: "00/22/44", repeatOn: "day")
        return [winter1, winter2]
    }
    var spring: [Suggestion] {
        let spring1 = Suggestion(name: "Lick a worm", description: "Then swallow it whole", startDate: "00/22/44", repeatOn: "year")
        let spring2 = Suggestion(name: "Lick a worm", description: "Then swallow it whole", startDate: "00/22/44", repeatOn: "year")
        return [spring1, spring2]
    }
    var summer: [Suggestion] {
        let summer1 = Suggestion(name: "Lick a worm", description: "Then swallow it whole", startDate: "00/22/44", repeatOn: "year")
        let summer2 = Suggestion(name: "Lick a worm", description: "Then swallow it whole", startDate: "00/22/44", repeatOn: "year")
        return [summer1, summer2]
    }
    var fall: [Suggestion] {
        let fall1 = Suggestion(name: "Lick a worm", description: "Then swallow it whole", startDate: "00/22/44", repeatOn: "year")
        let fall2 = Suggestion(name: "Lick a worm", description: "Then swallow it whole", startDate: "00/22/44", repeatOn: "year")
        return [fall1, fall2]
    }
}
