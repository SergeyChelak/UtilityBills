//
//  Mappers.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import Foundation

func mapPropertyObject(_ cdPropertyObject: CDPropertyObject) -> PropertyObject {
    PropertyObject(
        id: cdPropertyObject.uuid!,
        name: cdPropertyObject.name!,
        details: cdPropertyObject.details ?? "",
        currencyId: nil)
}

func mapMeter(_ cdMeter: CDMeter) -> Meter {
    Meter(
        id: cdMeter.uuid!,
        name: cdMeter.name!,
        capacity: cdMeter.capacity?.intValue,
        inspectionDate: cdMeter.inspectionDate
    )
}

func mapMeterValue(_ cdMeterValue: CDMeterValue) -> MeterValue {
    MeterValue(
        date: cdMeterValue.date!,
        value: cdMeterValue.value!.doubleValue,
        isPaid: cdMeterValue.isPaid,
        id: cdMeterValue.uuid!
    )
}

func mapTariff(_ cdTariff: CDTariff) -> Tariff {
    Tariff(
        id: cdTariff.uuid!,
        name: cdTariff.name!,
        price: cdTariff.price!.decimalValue as Decimal,
        activeMonthMask: Int(cdTariff.activeMonthMask)
    )
}

func mapBillingMap(_ cdBillingMap: CDBillingMap) -> BillingMap {
    let tariff = mapTariff(cdBillingMap.tariff!)
    let meters = cdBillingMap
        .meters!
        .map {
            mapMeter($0 as! CDMeter)
        }
    return BillingMap(
        id: cdBillingMap.uuid!,
        name: cdBillingMap.name!,
        order: Int(cdBillingMap.order),
        tariff: tariff,
        meters: meters
    )
}
