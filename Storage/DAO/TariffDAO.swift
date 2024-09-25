//
//  TariffDAO.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import Foundation

protocol TariffDAO {
    func allTariffs(for propertyId: PropertyObjectId) throws -> [Tariff]
    
    func newTariff(propertyId: PropertyObjectId, tariff: Tariff) throws
}
