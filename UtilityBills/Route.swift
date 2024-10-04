//
//  Route.swift
//  UtilityBills
//
//  Created by Sergey on 10.09.2024.
//

import Foundation

enum Route: Hashable {
    case properlyObjectList
    case propertyObjectHome(PropertyObjectId)
    case editPropertyInfo(PropertyObject)
    case addMeter(PropertyObjectId)
    case editMeter(Meter)
    case meterValues(MeterId)
    case addMeterValue(MeterId)
    case editMeterValue(MeterValue)
    case addTariff(PropertyObjectId)
    case editTariff(Tariff)
    case propertyObjectSettings(PropertyObjectId)
    case addBillingMap(BillingMapData)
    case editBillingMap(BillingMap, BillingMapData)
    case generateBill(PropertyObjectId)
//    case manageBillRecord(BillRecord)
}

protocol Router {
    func push(_ route: Route)
    func pop()
    func popToRoot()
    func showOverlay(_ route: Route)
    func hideOverlay()
}
