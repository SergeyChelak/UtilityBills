//
//  LocalStorage+MetersDAO.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import Foundation
import CoreData

extension LocalStorage: MetersDAO {
    func allMeters() throws -> [Meter] {
        let context = viewContext
        let request = CDMeter.fetchRequest()
        return try context.fetch(request).map(mapMeter)
    }
    
    func allMeters(_ propertyId: PropertyObjectId) throws -> [Meter] {
        let context = viewContext
        guard let obj = try fetchPropertyObject(propertyId, into: context) else {
            return []
        }
        let request = CDMeter.fetchRequest()
        request.predicate = .byPropertyObject(obj)
        return try context.fetch(request).map(mapMeter)
    }
    
    func deleteMeter(_ meterId: MeterId) throws {
        let context = viewContext
        let request = CDMeter.fetchRequest()
        request.predicate = .byOwnUUID(meterId)
        
        try context.fetch(request)
            .forEach {
                context.delete($0)
            }
        try context.save()
    }
    
    func newMeter(
        propertyObjectId: PropertyObjectId,
        meter: Meter,
        initialValue: Decimal
    ) throws {
        let context = viewContext
        guard let propertyObject = try fetchPropertyObject(propertyObjectId, into: context) else {
            throw StorageError.propertyObjectNotFound
        }
        let meterObj = CDMeter(context: context)
        meterObj.propertyObject = propertyObject
        meterObj.uuid = meter.id
        meterObj.name = meter.name
        meterObj.capacity = meter.capacity as? NSNumber
        meterObj.inspectionDate = meter.inspectionDate
        
        let initial: MeterValue = .initial(initialValue)
        _ = try createMeterValue(with: initial, for: meterObj)
        try context.save()
    }
        
    func meterValues(_ meterId: MeterId) throws -> [MeterValue] {
        let context = viewContext
        let request = CDMeterValue.fetchRequest()
        request.predicate = NSPredicate(format: "SELF.meter.uuid == %@", meterId.uuidString)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return try context.fetch(request).map(mapMeterValue)
    }
    
    func updateMeter(_ meter: Meter) throws {
        let context = viewContext
        guard let cdMeter = try fetchMeter(meter.id, into: context) else {
            throw StorageError.meterNotFound
        }
        cdMeter.name = meter.name
        cdMeter.inspectionDate = meter.inspectionDate
        try context.save()
    }
    
    func insertMeterValue(_ meterId: MeterId, value: MeterValue) throws {
        let context = viewContext
        guard let meter = try fetchMeter(meterId, into: context) else {
            throw StorageError.meterNotFound
        }
        _ = try createMeterValue(with: value, for: meter)
        try context.save()
    }
    
    func updateMeterValue(_ meterValue: MeterValue) throws {
        let context = viewContext
        guard let obj = try fetchMeterValue(meterValue.id, into: context) else {
            throw StorageError.meterValueNotFound
        }
        obj.date = meterValue.date
        obj.value = meterValue.value as NSDecimalNumber
        obj.isPaid = meterValue.isPaid
        try context.save()
    }
    
    func deleteMeterValue(_ meterValueId: MeterValueId) throws {
        let context = viewContext
        guard let obj = try fetchMeterValue(meterValueId, into: context) else {
            throw StorageError.meterValueNotFound
        }
        context.delete(obj)
        try context.save()
    }
    
    func fetchLatestValue(_ meterId: MeterId, isPaid: Bool) throws -> MeterValue? {
        let context = viewContext
        let request = CDMeterValue.fetchRequest()
        request.predicate = NSPredicate(format: "(SELF.meter.uuid == %@) AND (SELF.isPaid == %d)", meterId.uuidString, isPaid)
        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        guard let cdValue = try context.fetch(request).first else {
            return nil
        }
        return mapMeterValue(cdValue)
    }
}
