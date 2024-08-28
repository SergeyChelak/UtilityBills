//
//  HistoryBillService.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol HistoryBillService {
    func allHistoryBillItems(for property: PropertyObject) async throws -> [BillingItem]
}
