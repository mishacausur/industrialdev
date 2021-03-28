//
//  TabBarViewController.swift
//  Navigation
//
//  Created by Misha Causur on 28.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    let feedVc = FeedViewControllerFlowCoordinator()
    let profileVc = ProfileViewControllerFlowCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [feedVc.navigationViewController!, profileVc.navigationViewController!]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
