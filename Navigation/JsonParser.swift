//
//  JsonParser.swift
//  Navigation
//
//  Created by Misha Causur on 10.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

let session = URLSession.shared

/// Task 1

struct JsonModelForFirstTask: Codable {
    let userIdentifier: Int
    let identificator: Int
    let postTitle: String
    let checking: Bool
}

let taskOne = session.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!) {
    data, response, error in
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        print(error.debugDescription)
        return
    }
    guard let data = data else {
        print(error.debugDescription)
        return
    }
    if let rawValue = String(data: data, encoding: .utf8) {
        print("flfnfl")
        print(rawValue)
    }














struct JsonModel: Codable {
    let userIdentifier: Int
    let identificator: Int
    let postTitle: String
    let checking: Bool
    
    enum CodingKeys: String, CodingKey {
        case userIdentifier = "userId"
        case identificator = "id"
        case postTitle = "title"
        case checking = "completed"
    }
}



let urlForJson = "https://jsonplaceholder.typicode.com/todos/1"

let url = URL(string: urlForJson)!
//
//let postTask = session.dataTask(with: url) {data, response, error in
//    
//    guard error == nil else { fatalError() }
//    guard let postData = data else { fatalError() }
//    if let post = try? JSONDecoder().decode(JsonModel.self, from: postData) {
//        print(post.postTitle)
//    }
//}.resume()

}
