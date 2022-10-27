//
//  Notification.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/10/27.
//

import Foundation

enum NotificationType: Int {
    case follow
    case like
    case replt
    case retweet
    case mention
}

struct Notification {
    let tweetID: String?
    var timestamp: Date!
    let user: User
    let tweet: Tweet?
    var type: NotificationType!
    
    init(user: User, tweet: Tweet, dictionary: [String: AnyObject]) {
        self.user = user
        self.tweet = tweet
        
        self.tweetID = dictionary["tweetID"] as? String ?? ""
        
        if let timeStamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timeStamp)
        }
        
        if let type = dictionary["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
}
