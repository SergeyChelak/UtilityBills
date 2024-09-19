//
//  TariffDAO.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import Foundation

protocol TariffDAO {
    func allTariffs(for property: PropertyObjectId) throws -> [Tariff]
}
