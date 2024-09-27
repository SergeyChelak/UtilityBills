//
//  BillMapDAO.swift
//  UtilityBills
//
//  Created by Sergey on 27.09.2024.
//

import Foundation

protocol BillMapDAO {
    func allBillingMaps(_ propertyObjectId: PropertyObjectId) throws -> [BillingMap]
}
