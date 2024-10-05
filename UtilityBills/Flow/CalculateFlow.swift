//
//  iOSCalculateFlow.swift
//  UtilityBills
//
//  Created by Sergey on 03.10.2024.
//

import Foundation

class CalculateFlow {
    private let viewFactory: AppViewFactory
    private let storage: LocalStorage
    private let navigation: StackNavigation
    private let propertyObjectId: PropertyObjectId
    let updatePublisher: UpdatePublisher
    
    init(
        viewFactory: AppViewFactory,
        storage: LocalStorage,
        updatePublisher: UpdatePublisher,
        navigation: StackNavigation,
        propertyObjectId: PropertyObjectId
    ) {
        self.viewFactory = viewFactory
        self.storage = storage
        self.updatePublisher = updatePublisher
        self.navigation = navigation
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

// MARK: Flow
extension CalculateFlow: Flow {
    func start() {
        let view = viewFactory.generateBillView(propertyObjectId, flowDelegate: self)
        navigation.push(view)
    }
}

// MARK: CalculateFlowDelegate
extension CalculateFlow: CalculateFlowDelegate {
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
}

// MARK: ManageBillRecordFlow
extension CalculateFlow: ManageBillRecordFlowDelegate {
    func updateBillRecord(_ billRecord: BillRecord) {
//        fatalError()
        navigation.hideSheet()
    }
    
    func deleteBillRecord(_ billRecordId: BillRecordId) {
//        fatalError()
        navigation.hideSheet()
    }
}

fileprivate extension Tariff {
    var isActive: Bool {
        let month = Date().get(.month) - 1
        return activeMonthMask & (1 << month) > 0
    }
}
