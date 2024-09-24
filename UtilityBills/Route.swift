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
    case meterValues(MeterId)
    case addMeterValue(MeterId)
}

protocol Router {
    func push(_ route: Route)
    func pop()
    func popToRoot()
    func showOverlay(_ route: Route)
    func hideOverlay()
}
