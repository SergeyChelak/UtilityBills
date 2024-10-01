//
//  PropertyObject.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

typealias PropertyObjectId = UUID

struct PropertyObject {
    let id: PropertyObjectId
    var name: String
    var details: String
//    let type: PropertyObjectType
    var currencyId: String?
}

extension PropertyObject: Equatable, Hashable { }

struct PropertyObjectData {
    let propObj: PropertyObject?
    let meters: [Meter]
}
