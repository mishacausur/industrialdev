//
//  LoginChecker.swift
//  Navigation
//
//  Created by Misha Causur on 21.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

struct Checker {
    private var login = "Misha"
    private var password = "1234"
    
    static var shared = Checker()
    
    private init() {}
    
    func check(loginToCheck: String?, passwordToCheck: String?) -> Bool {
        if loginToCheck != nil && passwordToCheck == nil {
            if loginToCheck == login {
                return true
            } else { return false }
        }
        if passwordToCheck != nil && loginToCheck == nil {
            if passwordToCheck == password {
                return true
            } else { return false }
        }
        return false
    }
}


struct LoginChecker: LoginViewControllerDelegate {
    
    func checkLogin(login: String?) -> Bool {
        return Checker.shared.check(loginToCheck: login, passwordToCheck: nil)
    }
    
    func checkPassword(password: String?) -> Bool {
        return Checker.shared.check(loginToCheck: nil, passwordToCheck: password)
    }
    
}
