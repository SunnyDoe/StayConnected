//
//  TabBarViewController.swift
//  combineTest
//
//  Created by Imac on 29.11.24.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let homeVC = HomePageViewController()
        homeVC.view.backgroundColor = .white
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)

        let leaderboardVC = UIViewController()
        leaderboardVC.view.backgroundColor = .white
        leaderboardVC.tabBarItem = UITabBarItem(title: "Leaderboard", image: UIImage(named: "Leaderboard"), tag: 1)
        
        let profileVC = UIViewController()
        profileVC.view.backgroundColor = .white
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "Profile"), tag: 2)
        
        tabBar.tintColor = UIColor(red: 79/255, green: 70/255, blue: 229/255, alpha: 1.0)
        tabBar.backgroundColor = UIColor(red: 243/255, green: 242/255, blue: 241/255, alpha: 1.0)

        tabBar.unselectedItemTintColor = .gray

        self.viewControllers = [homeVC, leaderboardVC, profileVC]
    }
}


