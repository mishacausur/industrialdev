//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    
    let post: Post = Post(title: "Пост")
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "post" else {
            return
        }
        guard let postViewController = segue.destination as? PostViewController else {
            return
        }
        postViewController.post = post
        
//        guard  segue.identifier == "showLogInVC" else {
//            return
//        }
//        guard let logInVC = segue.destination as? LogInViewController else {
//            return
//        }
    }
   
    var updateTimer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
  
    func registerBackgroundTask() {
      backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
        self?.endBackgroundTask()
      }
      assert(backgroundTask != .invalid)
    }
      
    func endBackgroundTask() {
      print("Background task ended.")
      UIApplication.shared.endBackgroundTask(backgroundTask)
      backgroundTask = .invalid
    }
    
    func didTapPlayPause() {
        updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                           selector: #selector(counter), userInfo: nil, repeats: true)
        // register background task
        registerBackgroundTask()
     
     
    }
   var number = 0
    @objc func counter() {
        number += 1
        
        switch UIApplication.shared.applicationState {
        case .active:
         print("App is foregrounded")
        case .background:
          print("App is backgrounded. Next number = \(number)")
          print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
          print("\(String(describing: updateTimer))")
        case .inactive:
          break
        @unknown default:
            fatalError()
        }
    }
    @objc func reinstateBackgroundTask() {
      if updateTimer != nil && backgroundTask == .invalid {
        registerBackgroundTask()
      }
    }
}
