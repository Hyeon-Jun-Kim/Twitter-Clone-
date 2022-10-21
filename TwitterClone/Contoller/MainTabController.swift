//
//  MainTabController.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/10/12.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    // MARK: - Properties
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        logUserOut()
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfugureUI()
    }
    
    // MARK: API
    
    func fetchUser() {
        UserService.shared.fetchUser()
    }
    
    func authenticateUserAndConfugureUI() {
        if Auth.auth().currentUser == nil { // User is Not loggen in
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else { // User is loggen in
            configeureViewControllers()
            configureUI()
            fetchUser()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
            print("DUBUG: Did user log out.")
        } catch let error {
            print("DEBUG: Failed to Sign out with error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Selectors
    @objc
    func actionButtonTapped() {
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                            paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
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
