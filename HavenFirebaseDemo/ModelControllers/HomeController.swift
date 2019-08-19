//
//  HomeController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/13/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import Foundation
import Firebase

class HomeController {
    static let shared = HomeController()
    
    var currentHomeUID: String?
    
    func createHomeUsingFireStore(currentUserUID: String, name: String, zipcode: String, completion: @escaping (String) -> Void) {
        let path = "homes"
        let admins = [currentUserUID]
        let newHome = Home(uid: "", name: name, admins: admins, members: [], zipCode: zipcode)
        // Empty dictionary to begin with. Fields will get respectively updated during onboarding process.
        FirebaseController.shared.saveToFirebaseFirestoreAndGenerateUID(withPath: path, andWithDictionary: newHome.dictionary) { (uidString) in
            self.currentHomeUID = uidString
            let dictionary = ["uid": uidString]
            HomeController.shared.modifyCurrentHome(withHomeUID: uidString, withDictionary: dictionary)
            completion(uidString)
        }
    }
    
    // Takes in a dictionary and homeID
    func modifyCurrentHome(withHomeUID homeUID: String, withDictionary modifiedDictionary: [String: Any?]) {
        let path = "homes/\(homeUID)"
        
        FirebaseController.shared.updateDocumentFirebaseFirestore(withPath: path, andWithDictionary: modifiedDictionary as [String : Any]) { (isCompleted) in
            print("modified current home isCompleted is: \(isCompleted)")
        }
    }
    
    //  Send a friend request
//    func sendFriendRequest(recieverUID: String) {
//        if let currentUserUID = currentUser?.uid {
//            FriendRequestController.shared.createFriendRequestUsingFireStore(senderUID: currentUserUID, receiverUID: recieverUID) { (documentUID) in
//                // let dictionary = ["friendRequests": "\(unwrappedDocumentUID)"]
//                // let dictionary = ["friendRequestStatusPending": FieldValue.arrayUnion(["\(unwrappedDocumentUID)"])]
//                let dictionary1 = ["friendRequestStatusPending": FieldValue.arrayUnion(["\(recieverUID)"])]
//                // let dictionary2 = ["friendRequestStatusPending": FieldValue.arrayUnion(["\(currentUserUID)"])]
//                UserController.shared.updateUserFirebebaseFirestore(withUID: currentUserUID, andWithDictionary: dictionary1)
//                // UserController.shared.updateUserFirebebaseFirestore(withUID: recieverUID, andWithDictionary: dictionary2)
//                print("Data has been changed!! CHANGES")
//            }
//        } else {return}
//    }
//
//    func fetchUsersFirebaseFirestore(withUserName userName: String, completion: @escaping ([User]) -> Void) {
//        FirebaseController.shared.fetchDictionaryFirebaseFireStore(collectionPath: "users", type: "name", searchTerm: userName) { (userSnapshots) in
//            var fetchedUsers: [User] = []
//            for user in userSnapshots {
//                if let searchedUser = User(dictionary: user.data()) {
//                    searchedUser.uid = user.documentID
//                    fetchedUsers.append(searchedUser)} else {
//                    completion(fetchedUsers)
//                }
//            }
//            completion(fetchedUsers)
//        }
//    }
//
//    func fetchUsersFirebaseFirestore(withUID uID: String, completion: @escaping ([User]) -> Void) {
//        FirebaseController.shared.fetchDictionaryFirebaseFireStore(collectionPath: "users", type: "uid", searchTerm: uID) { (userSnapshots) in
//            var fetchedUsers: [User] = []
//            for user in userSnapshots {
//                if let searchedUser = User(dictionary: user.data()) {
//                    searchedUser.uid = user.documentID
//                    fetchedUsers.append(searchedUser)} else {
//                    completion(fetchedUsers)
//                }
//            }
//            completion(fetchedUsers)
//        }
//    }
//
//    // Searces from all users to see if there are any active friendRequests.
//    func fetchUsersFirebaseFirestoreFromFriendRequests(withUID uID: String, completion: @escaping ([User]) -> Void) {
//        FirebaseController.shared.fetchDictionaryFirebaseFireStore(collectionPath: "users", type: "friendRequestStatusPending", searchTerm: uID) { (userSnapshots) in
//            var fetchedUsers: [User] = []
//            for user in userSnapshots {
//                if let searchedUser = User(dictionary: user.data()) {
//                    searchedUser.uid = user.documentID
//                    fetchedUsers.append(searchedUser)} else {
//                    completion(fetchedUsers)
//                }
//            }
//            completion(fetchedUsers)
//        }
//    }
//
//    func fetchUserFriendsFirebaseFirestoreFromFriendRequests(withUID uID: String, completion: @escaping ([User]) -> Void) {
//        FirebaseController.shared.fetchDictionaryFirebaseFireStore(collectionPath: "users", type: "friends", searchTerm: uID) { (userSnapshots) in
//            var fetchedUsers: [User] = []
//            for user in userSnapshots {
//                if let searchedUser = User(dictionary: user.data()) {
//                    searchedUser.uid = user.documentID
//                    fetchedUsers.append(searchedUser)} else {
//                    completion(fetchedUsers)
//                }
//            }
//            completion(fetchedUsers)
//        }
//    }
//
//    func updateUserFirebebaseFirestore(withUID userUID: String, andWithDictionary dictionary: [String: Any]) {
//        let path = "users/\(userUID)"
//        FirebaseController.shared.updateDocumentFirebaseFirestore(withPath: path, andWithDictionary: dictionary) { (didUpdate) in
//            print(didUpdate)
//        }
//    }
}

