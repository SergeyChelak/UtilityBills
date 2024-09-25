//
//  LocalStorage+TariffDAO.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import Foundation

extension LocalStorage: TariffDAO {
    func allTariffs(for propertyId: PropertyObjectId) throws -> [Tariff] {
        let context = viewContext
        guard let obj = try fetchPropertyObject(propertyId, into: context) else {
            return []
        }
        let request = CDTariff.fetchRequest()
        request.predicate = .byPropertyObject(obj)
        return try context.fetch(request).map(mapTariff)
    }
    
    func newTariff(propertyId: PropertyObjectId, tariff: Tariff) throws {
        let context = viewContext
        guard let obj = try fetchPropertyObject(propertyId, into: context) else {
            throw StorageError.propertyObjectNotFound
        }
        let cdTariff = CDTariff(context: context)
        cdTariff.propertyObject = obj
        cdTariff.uuid = tariff.id
        cdTariff.name = tariff.name
        cdTariff.price = NSDecimalNumber(decimal: tariff.price)
        cdTariff.activeMonthMask = Int16(tariff.activeMonthMask)
        try context.save()
    }
}
