//
//  User.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/10/21.
//

import Foundation

struct User {
    let fullname: String
    let username: String
    let email: String
    let profileImageUrl: String
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? "" 
    }
}
