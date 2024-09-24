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
}
