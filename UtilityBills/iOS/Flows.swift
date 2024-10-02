//
//  Flows.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

import Foundation

protocol PropertyObjectListFlow: AnyObject {
    func loadPropertyObjects() throws -> [PropertyObject]
    func openPropertyObject(_ propertyObjectId: PropertyObjectId)
    func createPropertyObject() throws
}

protocol PropertyObjectFlow: AnyObject {
    var updatePublisher: UpdatePublisher { get }
    func loadPropertyObjectData(_ propertyObjectId: PropertyObjectId) throws -> PropertyObjectData
    func openEditPropertyObject(_ propertyObject: PropertyObject)
    func openMeterValues(_ meterId: MeterId)
    func openPropertyObjectSettings(_ propertyObjectId: PropertyObjectId)
    func openGenerateBill(_ propertyObjectId: PropertyObjectId)
}

protocol EditPropertyInfoFlow: AnyObject {
    func updatePropertyObject(_ propertyObject: PropertyObject) throws
}

protocol AddMeterFlow: AnyObject {
    func addNewMeter(_ meter: Meter, propertyObjectId: PropertyObjectId, initialValue: Double) throws
}

protocol MeterValuesListFlow: AnyObject {
    var updatePublisher: UpdatePublisher { get }
    func loadMeterValues(_ meterId: MeterId) throws -> [MeterValue]
    func addNewMeterValue(_ meterId: MeterId)
    func openMeterValue(_ meterValue: MeterValue)
}
