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
/// Модель для первого задания

struct JsonModelForFirstTask {
    let userIdentifier: Int?
    let identificator: Int?
    let postTitle: String?
    let checking: Bool?
    
}







/// Модель для второго задания

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

   
  
    
}
