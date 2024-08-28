//
//  TariffService.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol TariffService {
    func allTariff(for property: PropertyObject) async throws -> [Tariff]
    
    func createTariff(for property: PropertyObject) async throws -> Tariff
    
    func updateTariff(_ tariff: Tariff) async throws
    
    func deleteTariff(_ tariff: Tariff) async throws
}
