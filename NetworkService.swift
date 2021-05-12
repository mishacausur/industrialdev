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
    
    static func dataSessionTask(url: URL, completion: @escaping (String?) -> Void) {
        let dataSessionTask = dataSession.dataTask(with: url) { ( data, response, error )  in
            guard let taskResponse = response as? HTTPURLResponse, taskResponse.statusCode == 200 else { return }
            print("All Header Fields:", taskResponse.allHeaderFields, taskResponse.statusCode)
            if let data = data { completion(String(data: data, encoding: .utf8))}
            
        }.resume()
    }
}


enum AppConfiguration {
    case first(URL)
    case second(URL)
    case third(URL)
    
    func appConfig(_ configuration: AppConfiguration) -> URL {
        switch configuration {
        case .first(let url):
            return url
        case .second(let url):
            return url
        case .third(let url):
            return url
        }
    }
}
