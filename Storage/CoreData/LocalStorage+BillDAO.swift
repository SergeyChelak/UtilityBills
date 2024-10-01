//
//  LocalStorage+BillDAO.swift
//  UtilityBills
//
//  Created by Sergey on 01.10.2024.
//

import Foundation

extension LocalStorage: BillDAO {
    func allBills(_ propertyObjectId: PropertyObjectId) throws -> [Bill] {
        let context = viewContext
        guard let obj = try fetchPropertyObject(propertyObjectId, into: context) else {
            return []
        }
        let request = CDBill.fetchRequest()
        request.predicate = .byPropertyObject(obj)
        return try context
            .fetch(request)
            .map(mapBill)
    }
}
