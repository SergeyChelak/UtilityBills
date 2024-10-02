//
//  LocalStorage+BillDAO.swift
//  UtilityBills
//
//  Created by Sergey on 01.10.2024.
//

import Foundation

extension LocalStorage: BillDAO {
    func bills(_ propertyObjectId: PropertyObjectId, limit: Int?) throws -> [Bill] {
        let context = viewContext
        guard let obj = try fetchPropertyObject(propertyObjectId, into: context) else {
            return []
        }
        let request = CDBill.fetchRequest()
        request.predicate = .byPropertyObject(obj)
        if let limit {
            request.fetchLimit = limit
        }
        return try context
            .fetch(request)
            .map(mapBill)
    }
}
