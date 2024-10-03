//
//  iOSCalculateFlow.swift
//  UtilityBills
//
//  Created by Sergey on 03.10.2024.
//

import Foundation

class iOSCalculateFlow {
    private let storage: LocalStorage
    private let router: Router
    private let updatePublisher: UpdatePublisher
    private let propertyObjectId: PropertyObjectId
    
    init(
        router: Router,
        storage: LocalStorage,
        updatePublisher: UpdatePublisher,
        propertyObjectId: PropertyObjectId
    ) {
        self.router = router
        self.storage = storage
        self.updatePublisher = updatePublisher
        self.propertyObjectId = propertyObjectId
    }
    
    func calculateMetersDelta(_ meters: [Meter]) throws -> Decimal {
        guard !meters.isEmpty else {
            return Decimal(1.0)
        }
        return try meters
            .map {
                try calculateMeterDelta($0)
            }
            .reduce(0.0) { $0 + $1 }
    }
    
    func calculateMeterDelta(_ meter: Meter) throws -> Decimal {
        guard let paidValue = try storage.fetchLatestValue(meter.id, isPaid: true),
              let notPaidValue = try storage.fetchLatestValue(meter.id, isPaid: true),
              notPaidValue.date > paidValue.date else {
            return 0.0
        }
        return diff(notPaidValue.value, paidValue.value, capacity: meter.capacity)
    }
}

extension iOSCalculateFlow: CalculateFlow {
    func calculate() throws -> [BillRecord] {
        let billingMaps = try storage
            .allBillingMaps(propertyObjectId)
            .filter {
                $0.tariff.isActive
            }
        var result: [BillRecord] = []
        
        for billingMap in billingMaps {
            let amount = try calculateMetersDelta(billingMap.meters)
            let record = BillRecord(
                id: BillRecordId(),
                name: billingMap.name,
                amount: billingMap.meters.isEmpty ? nil : amount,
                price: amount * billingMap.tariff.price
            )
            result.append(record)
        }
        return result
    }
    
    func openBillRecord(_ billRecord: BillRecord) {
        fatalError()
    }
    
    func updateBillRecord(_ billRecord: BillRecord) {
        fatalError()
    }
    
    func deleteBillRecord(_ billRecordId: BillRecordId) {
        fatalError()
    }
}

fileprivate extension Tariff {
    var isActive: Bool {
        true
    }
}
