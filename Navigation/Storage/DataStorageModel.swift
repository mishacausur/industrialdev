//
//  DataStorageModel.swift
//  Navigation
//
//  Created by Misha Causur on 05.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import CoreData

class DataStorageModel {
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    func favoritePost(post: PostModel) {
        
        let favoritePost = DataPostModel(context: backgroundContext)
        favoritePost.autor = post.autor
        favoritePost.postDescription = post.description
        favoritePost.imageName = post.imageName
        favoritePost.views = String(post.views)
        favoritePost.likes = String(post.likes)
        backgroundContext.perform { [weak self] in
            do {
                try self?.backgroundContext.save()
            }
            catch let error {
                print(error)
            }
        }
    }
    
    func remove(post: DataPostModel) {
        viewContext.delete(post)
        do {
            try viewContext.save()
        }
        catch let error {
            print(error)
        }
    }
    
    func dataPostToPost(post: DataPostModel) -> PostModel {
        
        let autor = post.autor
        let description = post.postDescription
        let image = post.imageName
        let views = post.views
        let likes = post.likes
        
        let postModel = PostModel(autor: autor!, description: description!, imageName: image!, likes: Int(likes!)!, views: Int(views!)!)

            return postModel
    }
    
    func getFav(autor: String?) -> [DataPostModel] {
        let fetch: NSFetchRequest<DataPostModel> = DataPostModel.fetchRequest()
        fetch.fetchBatchSize = 5
        if let text = autor  {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(DataPostModel.autor), text)
            fetch.predicate = predicate
            do {
                return try viewContext.fetch(fetch)
            } catch {
                fatalError()
            }
        } else {
            do {
                return try viewContext.fetch(fetch)
            } catch {
                fatalError()
            }
        }
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.newBackgroundContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

