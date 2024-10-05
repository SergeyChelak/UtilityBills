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
    
    func saveBillRecords(_ propertyObjectId: PropertyObjectId, records: [BillRecord]) throws {
        guard !records.isEmpty else {
            return
        }
        let context = viewContext
        guard let obj = try fetchPropertyObject(propertyObjectId, into: context) else {
            return
        }
        let cdBill = CDBill(context: context)
        cdBill.propertyObject = obj
        cdBill.date = Date()
        cdBill.uuid = UUID()
        let cdRecords = records
            .enumerated()
            .map { order, val in
                let cdRecord = CDBillRecord(context: context)
                cdRecord.uuid = UUID()
                cdRecord.name = val.name
                cdRecord.amount = val.amount as? NSDecimalNumber
                cdRecord.price = val.price as NSDecimalNumber
                cdRecord.order = Int16(order)
                return cdRecord
        }
        cdBill.records = NSSet(array: cdRecords)
        try context.save()
    }
}
