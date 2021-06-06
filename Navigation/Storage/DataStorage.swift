//
//  DataStorage.swift
//  Navigation
//
//  Created by Misha Causur on 06.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class DataStorage {
    
    var dataStorage: DataStorageModel
    
    init(dataStorage: DataStorageModel) {
        self.dataStorage = dataStorage
    }
    
    func saveToFav(post: PostModel) {
        dataStorage.favoritePost(post: post)
    }
    
    func getFavorites() -> [DataPostModel] {
        dataStorage.getFav()
    }
    
    func toPost(post: DataPostModel) -> PostModel {
        dataStorage.dataPostToPost(post: post)
    }
    
}
