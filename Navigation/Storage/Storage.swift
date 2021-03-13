//
//  Storage.swift
//  Navigation
//
//  Created by Миша Козырь on 02.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

struct PostModel {
    let autor: String
    let description: String
    let imageName: String?
    let likes: Int
    let views: Int
}

struct Storage {
    static let posts = [
        PostModel(autor: "Misha", description: "My new illustration :)", imageName: "A4 - 95", likes: 34, views: 298),
        PostModel(autor: "Funny Frog", description: "Thank you for having me", imageName: "Frame 3", likes: 46, views: 311),
        PostModel(autor: "Misha", description: "Who wants coffee?", imageName: "Frame 1", likes: 32, views: 112),
        PostModel(autor: "Misha", description: "XOXO", imageName: "Frame5 2", likes: 43, views: 98)]

}

struct PhotoCollection {
    let image: UIImage
}

struct PhotoStorage {
    static let pics = [
        PhotoCollection(image: #imageLiteral(resourceName: "1")),
        PhotoCollection(image: #imageLiteral(resourceName: "14")),
        PhotoCollection(image: #imageLiteral(resourceName: "16")),
        PhotoCollection(image: #imageLiteral(resourceName: "4")),
        PhotoCollection(image: #imageLiteral(resourceName: "7")),
        PhotoCollection(image: #imageLiteral(resourceName: "6485")),
        PhotoCollection(image: #imageLiteral(resourceName: "2")),
        PhotoCollection(image: #imageLiteral(resourceName: "11")),
        PhotoCollection(image: #imageLiteral(resourceName: "18")),
        PhotoCollection(image: #imageLiteral(resourceName: "15")),
        PhotoCollection(image: #imageLiteral(resourceName: "20")),
        PhotoCollection(image: #imageLiteral(resourceName: "12")),
        PhotoCollection(image: #imageLiteral(resourceName: "8")),
        PhotoCollection(image: #imageLiteral(resourceName: "3")),
        PhotoCollection(image: #imageLiteral(resourceName: "10")),
        PhotoCollection(image: #imageLiteral(resourceName: "13")),
        PhotoCollection(image: #imageLiteral(resourceName: "9")),
        PhotoCollection(image: #imageLiteral(resourceName: "19")),
        PhotoCollection(image: #imageLiteral(resourceName: "17")),
        PhotoCollection(image: #imageLiteral(resourceName: "5"))
    ]
}
