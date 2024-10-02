//
//  BillDAO.swift
//  UtilityBills
//
//  Created by Sergey on 01.10.2024.
//

import Foundation

protocol BillDAO {
    func bills(_ propertyObjectId: PropertyObjectId, limit: Int?) throws -> [Bill]
}
