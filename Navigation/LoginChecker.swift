//
//  LoginChecker.swift
//  Navigation
//
//  Created by Misha Causur on 21.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//
import Foundation
import UIKit
import FirebaseAuth

struct LoginChecker: LoginViewControllerDelegate {
    
    func createUser(email: String, password: String) -> Bool {
        var check: Bool = false
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {result, error in
            guard error == nil else {
                check = false
                return
            }
            check = true
        })
        return check
    }
    
    
    func currentUser() {
        FirebaseAuth.Auth.auth().currentUser
    }
    
    
}
