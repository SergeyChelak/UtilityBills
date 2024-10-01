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
    
    func newBillingMap(_ propertyObjectId: PropertyObjectId, value: BillingMap) throws {
        let context = viewContext
        guard let obj = try fetchPropertyObject(propertyObjectId, into: context) else {
            throw StorageError.propertyObjectNotFound
        }
        guard let tariff = try fetchTariff(value.tariff.id, into: context) else {
            throw StorageError.tariffNotFound
        }
        let meters = try fetchMeters(value.meters.map { $0.id }, into: context)
        
        let billingMap = CDBillingMap(context: context)
        billingMap.propertyObject = obj
        billingMap.uuid = value.id
        billingMap.name = value.name
        billingMap.order = Int16(value.order)
        billingMap.tariff = tariff
        billingMap.meters = Set(meters) as NSSet
        try context.save()
    }
    
    func updateBillingMap(_ billingMap: BillingMap) throws {
        let context = viewContext
        guard let obj = try fetchBillingMap(billingMap.id, into: context) else {
            throw StorageError.billingMapNotFound
        }
        // TODO: review code duplicates
        guard let tariff = try fetchTariff(billingMap.tariff.id, into: context) else {
            throw StorageError.tariffNotFound
        }
        let meters = try fetchMeters(billingMap.meters.map { $0.id }, into: context)
        obj.name = billingMap.name
        obj.order = Int16(billingMap.order)
        obj.tariff = tariff
        obj.meters = Set(meters) as NSSet
        try context.save()
    }
    
    func deleteBillingMap(_ billingMapId: BillingMapId) throws {
        let context = viewContext
        guard let obj = try fetchBillingMap(billingMapId, into: context) else {
            throw StorageError.billingMapNotFound
        }
        context.delete(obj)
        try context.save()
    }
}
