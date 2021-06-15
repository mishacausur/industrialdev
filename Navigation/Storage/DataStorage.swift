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
    
    let dataStorage: DataStorageModel
    
    init(dataStorage: DataStorageModel) {
        self.dataStorage = dataStorage
    }
    
    func saveToFav(post: PostModel) {
        dataStorage.favoritePost(post: post)
    }
    
    func getFavorites(autor: String?) -> [DataPostModel] {
        dataStorage.getFav(autor: autor)
    }
    
    func toPost(post: DataPostModel) -> PostModel {
        dataStorage.dataPostToPost(post: post)
    }
    
    func deletePost(post: DataPostModel) {
        dataStorage.remove(post: post)
    }
    
}
