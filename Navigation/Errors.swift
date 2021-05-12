//
//  Errors.swift
//  Navigation
//
//  Created by Misha Causur on 04.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

enum LoginErrors: Error {
    case invalidUserData
    case serverDowntime
    case temporaryUserBlock
}
