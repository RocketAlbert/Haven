//
//  Users.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/12/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import Foundation

class User {
    var uid: String
    var email: String
    var name: String?
    var homes: [String]?
    
    init(uid: String, email: String, name: String?, homes:[String]?) {
        self.uid = uid
        self.email = email
        self.name = name
        self.homes = homes
    }
    
    var dictionary: [String : Any] {
        return [
            UserConstants.uidKey: self.uid,
            UserConstants.emailKey : self.email,
            UserConstants.nameKey : self.name ?? "",
            UserConstants.homesKey: self.homes ?? []
        ]
    }
}

// Slam dunk recieving from an entire dictionary
extension User {
    convenience init?(dictionary: [String : Any]) {
        guard let uid = dictionary[UserConstants.uidKey] as? String, let email = dictionary[UserConstants.emailKey] as? String, let name = dictionary[UserConstants.nameKey] as? String, let homes = dictionary[UserConstants.homesKey] as? [String] else {return nil}
        self.init(uid: uid, email: email, name: name, homes: homes)
    }
}

extension User {
    convenience init?(uid: String, email: String) {
        self.init(uid: uid, email: email, name: "", homes: [])
    }
}

// Conform to equatable.
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uid == rhs.uid
    }
}

struct UserConstants {
    static let typeKey = "User"
    fileprivate static let emailKey = "email"
    fileprivate static let nameKey = "name"
    fileprivate static let uidKey = "uid"
    fileprivate static let homesKey = "homes"
}
