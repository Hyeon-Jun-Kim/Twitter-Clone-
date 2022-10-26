//
//  Tweet.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/10/23.
//

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    var timestamp: Date!
    let reweetCount: Int
    var user: User
    var didLike = false
    
    init(user: User, tweetID: String, dictionary: [String: Any]) {
        self.tweetID = tweetID
        self.user = user
        
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.reweetCount = dictionary["retweets"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
