//
//  User.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/10/21.
//

import Foundation
import Firebase

struct User {
    let fullname: String
    let username: String
    let email: String
    var profileImageUrl: URL?
    let uid: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
    }
}
