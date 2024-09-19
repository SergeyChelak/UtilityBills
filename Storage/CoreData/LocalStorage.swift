//
//  LocalStorage.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation
import CoreData

struct LocalStorage {
    private static let modelName = "LocalStorageModel"
    
    public static func instance() -> Self {
        Self.init(modelName: modelName, inMemory: false)
    }
    
    public static func previewInstance() -> Self {
        Self.init(modelName: modelName, inMemory: true)
    }
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
        
    private init(modelName: String, inMemory: Bool) {
        let container = NSPersistentContainer(name: modelName)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { store, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }        
        self.persistentContainer = container
    }
}
