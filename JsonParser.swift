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
let session2 = URLSession.shared

/// Task 1

struct JsonModelForFirstTask {
    let userIdentifier: Int?
    let identificator: Int?
    let postTitle: String?
    let checking: Bool?
    
    static var textForLabel: String?
    
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
                    userIdentifier: dictionary["userId"] as! Int,
                    identificator: dictionary["id"] as! Int,
                    postTitle: dictionary["title"] as! String,
                    checking: dictionary["completed"] as! Bool)
                 model = firstTaskModel
                print(model)
                textForLabel = model.postTitle
            } 
        }.resume()
        
        return model
    }
    
}









struct JsonModel: Codable {
    
    let name: String?
    let rotation: String?
    let orbital: String?
    let diameter: String?
    let climate: String?
    let gravity: String?
    let terrain: String?
    let surfaceWater: String?
    let population: String?
    let residence: [String]?
    let films: [String]?
    let created: String?
    let updated: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case rotation = "rotation_period"
        case orbital = "orbital_period"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case terrain = "terrain"
        case surfaceWater = "surface_water"
        case population = "population"
        case residence = "residents"
        case films = "films"
        case created = "created"
        case updated = "edited"
        case url = "url"
    }

    static var orbital: String?
   
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
