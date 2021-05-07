//
//  NetworkService.swift
//  Navigation
//
//  Created by Misha Causur on 05.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct NetworkService {
    
    static var appConfigutator: AppConfiguration?
    
    static let dataSession = URLSession.shared
    
    static func dataTask(url: URL, completion: @escaping (String?) -> Void) {
        NetworkService.dataSession.dataTask(with: url) { ( data, response, error )  in
            guard let taskResponse = response as? HTTPURLResponse, taskResponse.statusCode == 200 else { return }
            print(taskResponse.allHeaderFields, taskResponse.statusCode)
            if data != nil { completion(String(data: data!, encoding: .utf8))}}.resume()
        }
    }


enum AppConfiguration {
    case first(URL)
    case second(URL)
    case third(URL)
}
