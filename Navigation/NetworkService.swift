//
//  NetworkService.swift
//  Navigation
//
//  Created by Misha Causur on 05.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct NetworkService {
    
    private static let dataSession = URLSession.shared
    
    static func dataTask(url: URL){
       
        dataSession.dataTask(with: url) { ( data, resume, error )  in }.resume()
        
    }
    
    
    
    
}
