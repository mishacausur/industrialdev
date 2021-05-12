//
//  AppDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appConfigurator: AppConfiguration?
    
    var url: URL?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Jnon")
        setUrlForConfigurator()
        guard  let appConfigurator = appConfigurator else { fatalError() }
        NetworkService.appConfigutator = appConfigurator
        guard let url = NetworkService.appConfigutator?.appConfig(appConfigurator) else { fatalError() }
        print(url)
        
        NetworkService.dataSessionTask(url: url) { string in
            if let data = string { print (data)
                }
        }
        return true
    }
    
    
    private func setUrlForConfigurator() {
        let randomNumber = Int.random(in: 0...2)
        if randomNumber == 0 {
            appConfigurator = .first(URL(string: "https://swapi.dev/api/people/8")!)
            
        }
        if randomNumber == 1 {
            appConfigurator = .second(URL(string: "https://swapi.dev/api/starships/3")!)
            print("2")
        }
        if randomNumber == 2 {
            appConfigurator = .third(URL(string: "https://swapi.dev/api/planets/5")!)
            print("3")
        }
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

