//
//  TariffDAO.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import Foundation

protocol TariffDAO {
    func allTariffs(_ propertyId: PropertyObjectId) throws -> [Tariff]
    
    func newTariff(propertyId: PropertyObjectId, tariff: Tariff) throws
    
    func updateTariff(tariff: Tariff) throws
    
    func deleteTariff(tariffId: TariffId) throws
}
