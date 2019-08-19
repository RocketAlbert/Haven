//
//  UserController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/13/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import Foundation
import Firebase

class UserController {
    static let shared = UserController()
    
    var currentUser = FirebaseController.shared.currentUser
    
    func createUserUsingFireStore(_ email: String) {
        guard let uid = FirebaseController.shared.currentUser?.uid else {return}
        let newUser = User(uid: uid, email: email)
        let path = "users/\(newUser!.uid)"
        FirebaseController.shared.saveToFirebaseFirestore(withPath: path, andWithDictionary: newUser!.dictionary, completion: { (userSaveCompleted) in
            print(userSaveCompleted)
        })
    }
    
    func fetchUsersFirebaseFirestore(withUserName userName: String, completion: @escaping ([User]) -> Void) {
        FirebaseController.shared.fetchDictionaryFirebaseFireStore(collectionPath: "users", type: "name", searchTerm: userName) { (userSnapshots) in
            var fetchedUsers: [User] = []
            for user in userSnapshots {
                if let searchedUser = User(dictionary: user.data()) {
                    searchedUser.uid = user.documentID
                    fetchedUsers.append(searchedUser)} else {
                    completion(fetchedUsers)
                }
            }
            completion(fetchedUsers)
        }
    }
    
    func fetchUsersFirebaseFirestore(withUID uID: String, completion: @escaping ([User]) -> Void) {
        FirebaseController.shared.fetchDictionaryFirebaseFireStore(collectionPath: "users", type: "uid", searchTerm: uID) { (userSnapshots) in
            var fetchedUsers: [User] = []
            for user in userSnapshots {
                if let searchedUser = User(dictionary: user.data()) {
                    searchedUser.uid = user.documentID
                    fetchedUsers.append(searchedUser)} else {
                    completion(fetchedUsers)
                }
            }
            completion(fetchedUsers)
        }
    }
    
    // Searces from all users to see if there are any active friendRequests.
    func fetchUsersFirebaseFirestoreFromFriendRequests(withUID uID: String, completion: @escaping ([User]) -> Void) {
        FirebaseController.shared.fetchDictionaryFirebaseFireStore(collectionPath: "users", type: "friendRequestStatusPending", searchTerm: uID) { (userSnapshots) in
            var fetchedUsers: [User] = []
            for user in userSnapshots {
                if let searchedUser = User(dictionary: user.data()) {
                    searchedUser.uid = user.documentID
                    fetchedUsers.append(searchedUser)} else {
                    completion(fetchedUsers)
                }
            }
            completion(fetchedUsers)
        }
    }
    
    func fetchUserFriendsFirebaseFirestoreFromFriendRequests(withUID uID: String, completion: @escaping ([User]) -> Void) {
        FirebaseController.shared.fetchDictionaryFirebaseFireStore(collectionPath: "users", type: "friends", searchTerm: uID) { (userSnapshots) in
            var fetchedUsers: [User] = []
            for user in userSnapshots {
                if let searchedUser = User(dictionary: user.data()) {
                    searchedUser.uid = user.documentID
                    fetchedUsers.append(searchedUser)} else {
                    completion(fetchedUsers)
                }
            }
            completion(fetchedUsers)
        }
    }
    
    func updateUserFirebebaseFirestore(withUID userUID: String, andWithDictionary dictionary: [String: Any]) {
        let path = "users/\(userUID)"
        FirebaseController.shared.updateDocumentFirebaseFirestore(withPath: path, andWithDictionary: dictionary) { (didUpdate) in
            print(didUpdate)
        }
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


