//
//  MockUtils.swift
//  UtilityBills
//
//  Created by Sergey on 09.10.2024.
//

#if DEBUG
import Foundation

func _propertyObject() -> PropertyObject {
    PropertyObject(
        id: PropertyObjectId(),
        name: "PO #1",
        details: "PO details")
}

func _randPropertyObject() -> PropertyObject {
    PropertyObject(
        id: PropertyObjectId(),
        name: "Obj #" + String(arc4random()),
        details: "Details " + String(arc4random())
    )
}

func _meter() -> Meter {
    Meter(
        id: MeterId(),
        name: "Unknown Meter",
        capacity: 9,
        inspectionDate: nil
    )
}

func _randMeter() -> Meter {
    Meter(
        id: MeterId(),
        name: "Mtr #" + String(arc4random()),
        capacity: nil,
        inspectionDate: Date()
    )
}
#endif
