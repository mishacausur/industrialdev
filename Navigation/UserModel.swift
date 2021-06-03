//
//  UserModel.swift
//  Navigation
//
//  Created by Misha Causur on 03.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//
import RealmSwift
import Foundation

@objcMembers class UserRealm: Object {
     dynamic var login: String?
     dynamic var password: String?
    
  
}

