//
//  NSPredicate+CoreData.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import CoreData
import Foundation

extension NSPredicate {
    static func byOwnUUID(_ uuid: UUID) -> NSPredicate {
        NSPredicate(format: "SELF.uuid == %@", uuid.uuidString)
    }
    
    static func byPropertyObject(_ obj: NSManagedObject) -> NSPredicate {
        NSPredicate(format: "SELF.propertyObject == %@", obj)
    }
}
