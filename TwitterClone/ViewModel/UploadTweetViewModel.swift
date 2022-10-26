//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/10/25.
//

import UIKit

enum UploaddTweetConfiguartion {
    case tweet
    case reply(Tweet)
}

struct UploadTweetViewModel {
    let actionButtonTitle: String
    let placeholderText: String
    var shouldShowReplyLabel : Bool
    var replyText: String?
    
    init(config: UploaddTweetConfiguartion) {
        switch config {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeholderText = "What's happening"
            shouldShowReplyLabel = false
        case .reply(let tweet):
            actionButtonTitle = "Reply"
            placeholderText = "Tweet yout reply"
            shouldShowReplyLabel = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}
