//
//  LocalStorage+TariffDAO.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import Foundation

extension LocalStorage: TariffDAO {
    func allTariffs(for property: PropertyObjectId) throws -> [Tariff] {
        fatalError()
    }
}
