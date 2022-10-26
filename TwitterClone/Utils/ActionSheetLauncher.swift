//
//  ActionSheetLauncher.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/10/26.
//

import UIKit

private let reuseIdentifier = "ActionSheetCell"

class ActionSheetLauncher: NSObject {
    
    // MARK: - Properties
    
    private let user: User
    private let tableview = UITableView()
    private var window: UIWindow?
    
    // MARK: - Lifecycle
    
    init(user: User){
        self.user = user
        super.init()
        configureTableView()
    }
    
    // MARK: - Helpers
    
    func show() {
        print("DEBUG: Show action sheet for user \(user.username)")
        
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        self.window = window
        
        window.addSubview(tableview)
        tableview.frame = CGRect(x: 0, y: window.frame.height - 300,
                                 width: window.frame.width, height: 300)
    }
    
    func configureTableView() {
        tableview.backgroundColor = .twitterBlue
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 60
        tableview.separatorStyle = .none
        tableview.layer.cornerRadius = 5
        tableview.isScrollEnabled = false
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

extension ActionSheetLauncher: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    
}

extension ActionSheetLauncher: UITableViewDelegate {
    
}
