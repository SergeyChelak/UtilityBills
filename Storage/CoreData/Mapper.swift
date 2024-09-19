//
//  Mapper.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import Foundation

func map(_ cdPropertyObject: CDPropertyObject) -> PropertyObject {
    PropertyObject(
        id: cdPropertyObject.uuid!,
        name: cdPropertyObject.name!,
        details: cdPropertyObject.details ?? "",
        currencyId: nil)
}

func map(_ cdMeter: CDMeter) -> Meter {
    Meter(
        id: cdMeter.uuid!,
        name: cdMeter.name!,
        capacity: cdMeter.capacity?.intValue,
        inspectionDate: cdMeter.inspectionDate
    )
}

func map(_ cdMeterValue: CDMeterValue) -> MeterValue {
    MeterValue(
        date: cdMeterValue.date!,
        value: cdMeterValue.value!.doubleValue,
        isPaid: cdMeterValue.isPaid,
        id: cdMeterValue.uuid!
    )
}
