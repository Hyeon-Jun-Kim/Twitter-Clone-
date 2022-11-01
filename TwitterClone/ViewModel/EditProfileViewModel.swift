//
//  EditProfileViewModel.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/11/02.
//

import Foundation
import SystemConfiguration

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case username
    case bio
    
    var description: String {
        switch self {
        case .username : return "Username"
        case .fullname : return "Name"
        case .bio : return "bio"
        }
    }
    
    
}
