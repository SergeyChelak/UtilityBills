//
//  BillDAO.swift
//  UtilityBills
//
//  Created by Sergey on 01.10.2024.
//

import Foundation

protocol BillDAO {
    func allBills(_ propertyObjectId: PropertyObjectId) throws -> [Bill]
}
