//
//  CoreDataManager.swift
//  Soccer MVVM
//
//  Created by Leonardo Oliveira on 02/11/20.
//  Copyright © 2020 LeonardoAOliveira. All rights reserved.
//

import CoreData

final class CoreDataManager {
    
    private let model: String
    
    private lazy var storeDescription: NSPersistentStoreDescription = {
        let url = NSPersistentContainer.defaultDirectoryURL()
        let sqlite = url.appendingPathComponent("\(model).sqlite")
        let storeDescription = NSPersistentStoreDescription(url: sqlite)
        storeDescription.shouldAddStoreAsynchronously = false 
        storeDescription.shouldMigrateStoreAutomatically = true
        storeDescription.shouldInferMappingModelAutomatically = true
        return storeDescription
    }()
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: model)
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    lazy var backgroundContex: NSManagedObjectContext = {
        let context = container.newBackgroundContext()
        return context
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(model: String) {
        self.model = model
    }
}
