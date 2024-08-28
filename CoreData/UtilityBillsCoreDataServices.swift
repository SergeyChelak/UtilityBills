//
//  UtilityBillsCoreDataServices.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation
import CoreData

struct UtilityBillsCoreDataServices {
    private static let modelName = "UtilityBillsStorage"
    
    public static func services() -> Self {
        Self.init(modelName: modelName, inMemory: false)
    }
    
    public static func previewServices() -> Self {
        Self.init(modelName: modelName, inMemory: true)
    }
    
    private let persistentContainer: NSPersistentContainer
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private let backgroundContext: NSManagedObjectContext
    
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
        self.backgroundContext = container.newBackgroundContext()
    }
}
