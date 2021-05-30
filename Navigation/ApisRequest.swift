//
//  ApisRequest.swift
//  Navigation
//
//  Created by Misha Causur on 30.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

struct ApiRequest {
    
    /// Переменная для передачи значения на вьюконтроллер
    static var textForLabel: String?
    
    /// Функция парсинга для первой задачи
    static func parsingFirstTask(url: URL, completion: @escaping (String?) -> Void) -> JsonModelForFirstTask {
        var model = JsonModelForFirstTask(userIdentifier: nil, identificator: nil, postTitle: nil, checking: nil)
        let taskOne = session.dataTask(with: url) {
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
            if let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String,Any> {
                let firstTaskModel = JsonModelForFirstTask (
                    userIdentifier: dictionary["userId"] as? Int,
                    identificator: dictionary["id"] as? Int,
                    postTitle: dictionary["title"] as? String,
                    checking: dictionary["completed"] as? Bool)
                 model = firstTaskModel
                print(model)
                textForLabel = model.postTitle
            }
        }.resume()
        
        return model
    }
    
    ///Переменная для второй задачи
    static var orbital: String?
    
    
    /// Функция парсинга для второй задачи
    static func parsingJson(url: URL, completion: @escaping (Data?) -> Void) -> JsonModel {
        var parserModel =  JsonModel(name: "", rotation: "", orbital: "", diameter: "", climate: "", gravity: "", terrain: "", surfaceWater: "", population: "", residence: [""], films: [""], created: "", updated: "", url: "")
        let task = session2.dataTask(with: url) {data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print(error.debugDescription)
                return
            }
            guard error == nil else { fatalError() }
            guard let postData = data else { fatalError() }
            if let post = try? JSONDecoder().decode(JsonModel.self, from: postData){
                parserModel = post
                orbital = parserModel.orbital
            DispatchQueue.main.sync {
                completion(postData) }
            }
        }.resume()
        return parserModel
    }
}


