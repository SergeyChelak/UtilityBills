//
//  Mappers.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import Foundation

func mapPropertyObject(_ cdPropertyObject: CDPropertyObject) throws -> PropertyObject {
    guard let id = cdPropertyObject.uuid,
          let name = cdPropertyObject.name else {
        throw StorageError.remappingFailed("id/name contain nil")
    }
    return PropertyObject(
        id: id,
        name: name,
        details: cdPropertyObject.details ?? "",
        currencyId: nil)
}

func mapMeter(_ cdMeter: CDMeter) throws -> Meter {
    guard let id = cdMeter.uuid,
          let name = cdMeter.name else {
        throw StorageError.remappingFailed("id/name contain nil")
    }
    return Meter(
        id: id,
        name: name,
        capacity: cdMeter.capacity?.intValue,
        inspectionDate: cdMeter.inspectionDate
    )
}

func mapMeterValue(_ cdMeterValue: CDMeterValue) throws -> MeterValue {
    guard let id = cdMeterValue.uuid,
          let date = cdMeterValue.date,
          let value = cdMeterValue.value as? Decimal else {
        throw StorageError.remappingFailed("id/date/value contain nil")
    }
    return MeterValue(
        id: id,
        date: date,
        value: value,
        isPaid: cdMeterValue.isPaid
    )
}

func mapTariff(_ cdTariff: CDTariff) throws -> Tariff {
    guard let id = cdTariff.uuid,
          let name = cdTariff.name,
          let price = cdTariff.price else {
        throw StorageError.remappingFailed("id/name/price contain nil")
    }
    return Tariff(
        id: id,
        name: name,
        price: price.decimalValue as Decimal,
        activeMonthMask: Int(cdTariff.activeMonthMask)
    )
}

func mapBillingMap(_ cdBillingMap: CDBillingMap) throws -> BillingMap {
    guard let cdTariff = cdBillingMap.tariff,
          let cdMeters = cdBillingMap.meters else {
        throw StorageError.remappingFailed("tariff/meter contain nil")
    }
    let tariff = try mapTariff(cdTariff)
    let meters = try cdMeters
        .map {
            try mapMeter($0 as! CDMeter)
        }
    guard let id = cdBillingMap.uuid,
          let name = cdBillingMap.name else {
        throw StorageError.remappingFailed("id/name contain nil")
    }
    return BillingMap(
        id: id,
        name: name,
        order: Int(cdBillingMap.order),
        tariff: tariff,
        meters: meters
    )
}

func mapBill(_ cdBill: CDBill) throws -> Bill {
    guard let cdBillRecords = cdBill.records,
          let id = cdBill.uuid,
          let date = cdBill.date else {
        throw StorageError.remappingFailed("bill records/id/date contain nil")
    }
    let records = try cdBillRecords
        .map {
            try mapBillRecord($0 as! CDBillRecord)
        }
    return Bill(
        id: id,
        date: date,
        records: records
    )
}

func mapBillRecord(_ cdBillRecord: CDBillRecord) throws -> BillRecord {
    guard let id = cdBillRecord.uuid,
          let price = cdBillRecord.price else {
        throw StorageError.remappingFailed("id/price contain nil")
    }
    return BillRecord(
        id: id,
        name: cdBillRecord.name ?? "",
        amount: price.decimalValue as Decimal,
        price: price.decimalValue as Decimal
    )
}
