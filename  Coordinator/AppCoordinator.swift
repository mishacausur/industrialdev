//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Misha Causur on 28.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol Coordinator {
    
    var loadViewController: UIViewController { get }
    var navigationViewController: UINavigationController? { get }
    
    func start()
}

class AppCoordinator: Coordinator {

    var loadViewController: UIViewController = TabBarViewController()
    
    var navigationViewController: UINavigationController?
    
    init(window: UIWindow) {
        window.rootViewController = loadViewController
        window.makeKeyAndVisible()
    }
    
    func start() {}
}

class FeedViewControllerFlowCoordinator: Coordinator {
   
    var loadViewController: UIViewController = FeedViewController()
    
    var navigationViewController: UINavigationController?
    
    init() {
        
       let feedViewController = FeedViewController()
        
        navigationViewController = UINavigationController(rootViewController: feedViewController)
        
        feedViewController.coordinator = self
        
        navigationViewController!.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
    }
    
    func start() {}
    
    func pushViewController(_ post: Post){
        let postVC = PostViewController()
        postVC.coordinator = self
        postVC.post = post
        navigationViewController?.pushViewController(postVC, animated: true)
    }
    
    func pushInfoVC() {
        let infoVC = InfoViewController()
        navigationViewController?.present(infoVC, animated: true, completion: nil)
    }
}

class ProfileViewControllerFlowCoordinator: Coordinator {
   
    var loadViewController: UIViewController = LogInViewController()
    
    var navigationViewController: UINavigationController?
    
    init() {
        
        let loginVC = LogInViewController()
        loginVC.coordinator = self
        
       navigationViewController = UINavigationController(rootViewController: loginVC)
        
        navigationViewController!.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
    }
    
    func start() {}
    
    func pushProfileViewController() {
        let profileVC = ProfileViewController()
        profileVC.coordinator = self
        navigationViewController?.pushViewController(profileVC, animated: true)
    }
    
    func pushCollection() {
        let vc = PhotosViewController()
        navigationViewController?.pushViewController(vc, animated: true)
    }
}

