//
//  LocalStorage+BillMapDAO.swift
//  UtilityBills
//
//  Created by Sergey on 27.09.2024.
//

import Foundation

extension LocalStorage: BillMapDAO {
    func allBillingMaps(_ propertyObjectId: PropertyObjectId) throws -> [BillingMap] {
        let context = viewContext
        guard let obj = try fetchPropertyObject(propertyObjectId, into: context) else {
            return []
        }
        let request = CDBillingMap.fetchRequest()
        request.predicate = .byPropertyObject(obj)
        return try context.fetch(request).map(mapBillingMap)
    }
}
