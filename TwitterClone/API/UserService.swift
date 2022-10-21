//
//  UserService.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/10/21.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        print("Fetch")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            print("DEBUG: dictionary is \(dictionary)")
        }
    }
}
