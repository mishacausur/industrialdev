//
//  DataPostModel+CoreDataProperties.swift
//  Navigation
//
//  Created by Misha Causur on 05.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//
//

import Foundation
import CoreData


extension DataPostModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataPostModel> {
        return NSFetchRequest<DataPostModel>(entityName: "DataPostModel")
    }

    @NSManaged public var autor: String?
    @NSManaged public var postDescription: String?
    @NSManaged public var imageName: String?
    @NSManaged public var likes: String?
    @NSManaged public var views: String?

}

extension DataPostModel : Identifiable {

}
