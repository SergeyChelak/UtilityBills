//
//  LocalStorage+MetersDAO.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import Foundation

extension LocalStorage: MetersDAO {
    func allMeters(for propertyId: PropertyObjectId) throws -> [Meter] {
        let context = viewContext
        guard let obj = try fetchPropertyObject(propertyId, into: context) else {
            return []
        }
        let request = CDMeter.fetchRequest()
        request.predicate = .byPropertyObject(obj)
        return try context.fetch(request).map(mapMeter)
    }
    
    func newMeter(
        propertyObjectId: PropertyObjectId,
        meter: Meter,
        initialValue: Double
    ) throws -> Meter {
        let context = viewContext
        guard let propertyObject = try fetchPropertyObject(propertyObjectId, into: context) else {
            // TODO: fix this
            throw NSError()
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
        
        return mapMeter(meterObj)

    }
        
    func meterValues(_ meterId: MeterId) throws -> [MeterValue] {
        let context = viewContext
        let request = CDMeterValue.fetchRequest()
        request.predicate = NSPredicate(format: "SELF.meter.uuid == %@", meterId.uuidString)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return try context.fetch(request).map(mapMeterValue)
    }
    
    func insertMeterValue(_ meterId: MeterId, value: MeterValue) throws {
        let context = viewContext
        guard let meter = try fetchMeter(meterId, into: context) else {
            // TODO: fix error type
            throw NSError()
        }
        _ = try createMeterValue(with: value, for: meter)
        try context.save()
    }
}
