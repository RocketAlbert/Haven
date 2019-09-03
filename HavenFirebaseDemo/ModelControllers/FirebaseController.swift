//
//  FirebaseController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/12/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.

import Foundation
import Firebase

class FirebaseController {
    
    // Shared Instance
    static let shared = FirebaseController()
    
    // Current authenticated user.
    var currentUser = Auth.auth().currentUser
    // var currentUserUID: String?
    
    // Reference to storage.
    let db = Firestore.firestore()
    
    func configureNext() {
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
    }
    
    // Authentication
    // Authenticate a new user.
    func authenticateUser(withEmail email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) \(error.localizedDescription)")
                completion (false)
                return
            }
            
            guard let user = result?.user else {completion(false) ; return}
            self.currentUser = user
            // self.currentUserUID = user.uid
            
            
            print("Authenticated user successfully, userID: \(user.uid)")
            completion(true)
        }
    }
    
    // Sign in an existing user.
    func signInUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) \(error.localizedDescription)")
                return
            }
            guard let user = authResult?.user else {return}
            self.currentUser = user
        }
    }
    
    // Takes a path and begins a new document with a new dicionary. Emphasis on dictionary.
    func saveToFirebaseFirestore(withPath path: String, andWithDictionary dictionary: [String: Any], completion: @escaping (Bool) -> Void) {
        var docRef: DocumentReference!
        docRef = Firestore.firestore().document(path)
        docRef.setData(dictionary) { (error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) \(error.localizedDescription)")
                completion (false)
                return
            } else {
                print("Data has been saved!")
            }
        }
    }
    
    
    func saveToFirebaseFirestoreAndGenerateUID(withPath path: String, andWithDictionary dictionary: [String: Any], completion: @escaping (String) -> Void) {
        var docRef: DocumentReference!
        docRef = Firestore.firestore().collection(path).document()
        docRef.setData(dictionary) { (error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) \(error.localizedDescription)")
                completion ("error")
                return
            } else {
                completion(docRef!.documentID)
            }
        }
    }
    
    // READ
    // Fetches document with search term, of a type within a collection. Returns FIRDocumnentSnapshots.\ which separate into:
    // "document.documentID" and "document.data()"
    func fetchDictionaryFirebaseFireStore(collectionPath: String, type: String, searchTerm: String, completion: @escaping ([QueryDocumentSnapshot]) -> Void)  {
        db.collection(collectionPath).whereField(type, isEqualTo: searchTerm).getDocuments() {(querySnapshot, err) in
            var foundSnapshots: [QueryDocumentSnapshot] = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    foundSnapshots.append(document)
                }
            }
            // Returns the snapshot.
            completion(foundSnapshots)
        }
    }
    
    // Uses array contains.
    func fetchDictionaryFirebaseFireStoreWithContains(collectionPath: String, type: String, searchTerm: String, completion: @escaping ([QueryDocumentSnapshot]) -> Void)  {
        db.collection(collectionPath).whereField(type, arrayContains: searchTerm).getDocuments() {(querySnapshot, err) in
            var foundSnapshots: [QueryDocumentSnapshot] = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    foundSnapshots.append(document)
                }
            }
            // Returns the snapshot.
            completion(foundSnapshots)
        }
    }
    
    // UPDATE
    // Takes a path and updates a dictionary within a document.
    func updateDocumentFirebaseFirestore(withPath path: String, andWithDictionary dictionary: [String: Any], completion: @escaping (Bool) -> Void) {
        var docRef: DocumentReference!
        docRef = Firestore.firestore().document(path)
        docRef.updateData(dictionary) { (error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) \(error.localizedDescription)")
                completion (false)
                return
            } else {
                completion(true)
                print("Data has been updated!")
            }
        }
    }
    
    func removeDocumentFirebaseFirestore(withPath path: String, completion: @escaping (Bool) -> Void) {
        var docRef: DocumentReference!
        docRef = Firestore.firestore().document(path)
        docRef.delete { (error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) \(error.localizedDescription)")
                completion (false)
            }
        }
    }
    
    // Sign out user.
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
        } catch {
            print("\(error)")
        }
    }
}
