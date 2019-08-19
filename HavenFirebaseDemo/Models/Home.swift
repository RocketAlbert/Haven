//
//  Home.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/12/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//



import Foundation

class Home {
    var uid: String?
    var name: String?
    var admins: [String]?
    var members: [String]?
    var zipCode: String?
    
    init(uid: String?, name: String, admins: [String], members: [String]?, zipCode: String) {
        self.uid = uid
        self.name = name
        self.admins = admins
        self.members = members
        self.zipCode = zipCode
    }
    
    var dictionary: [String : Any] {
        return [
            HomeConstants.uidKey: self.uid ?? "",
            HomeConstants.nameKey: self.name ?? "",
            HomeConstants.adminsKey: self.admins ?? [],
            HomeConstants.membersKey: self.members ?? [],
            HomeConstants.zipCodeKey: self.zipCode ?? ""
        ]
    }
}

// Slam dunk recieving from an entire dictionary
extension Home {
    convenience init?(dictionary: [String : Any]) {
        guard let uid = dictionary[HomeConstants.uidKey] as? String, let name = dictionary[HomeConstants.nameKey] as? String, let admins = dictionary[HomeConstants.adminsKey] as? [String], let members = dictionary[HomeConstants.adminsKey] as? [String], let zipCode = dictionary[HomeConstants.zipCodeKey] as? String else {return nil}
        self.init(uid: uid, name: name, admins: admins, members: members, zipCode: zipCode)
    }
}

extension Home {
    convenience init?(uid: String) {
        self.init(uid: uid, name: "", admins: [], members: [], zipCode: "")
    }
}

// Conform to equatable.
extension Home: Equatable {
    static func == (lhs: Home, rhs: Home) -> Bool {
        return lhs.uid == rhs.uid
    }
}

struct HomeConstants {
    static let typeKey = "Home"
    fileprivate static let nameKey = "name"
    fileprivate static let uidKey = "uid"
    fileprivate static let adminsKey = "admins"
    fileprivate static let membersKey = "members"
    fileprivate static let zipCodeKey = "zipCode"
}
