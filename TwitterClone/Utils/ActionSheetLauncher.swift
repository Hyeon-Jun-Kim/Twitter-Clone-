//
//  ActionSheetLauncher.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/10/26.
//

import Foundation

class ActionSheetLauncher: NSObject {
    
    // MARK: - Properties
    
    private let user: User
    
    init(user: User){
        self.user = user
        super.init()
    }
    
    // MARK: - Helpers
    
    func show() {
        print("DEBUG: Show action sheet for user \(user.fullname)")
    }
}
