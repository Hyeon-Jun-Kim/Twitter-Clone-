//
//  MainTabController.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/10/12.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configeureViewControllers()
    }
    
    // MARK: - Helpers
    
    func configeureViewControllers() {
        let feed = FeedController()
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootviewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootviewController: explore)
        
        let notifications = NotificationsController()
        let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootviewController: notifications)
        
        let conversations = ConversationsController()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootviewController: conversations)
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }

    func templateNavigationController(image: UIImage?, rootviewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootviewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
}
