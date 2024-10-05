//
//  PropertyObjectViewModelMock.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

#if DEBUG
import Foundation
private class PropertyObjectFlowMock: PropertyObjectFlowDelegate {
    let updatePublisher: UpdatePublisher = UpdatePublisherMock()
    let objId = PropertyObjectId()
    func loadPropertyObjectData(_ propertyObjectId: PropertyObjectId) throws -> PropertyObjectData {
        let obj = PropertyObject(id: UUID(), name: "House", details: "My home")
        let meters: [Meter] = [
            // TODO: ...
        ]
        let bills: [Bill] = [
            // TODO: ...
        ]
        return PropertyObjectData(
            propObj: obj,
            meters: meters,
            bills: bills
        )
    }
    
    func openEditPropertyObject(_ propertyObject: PropertyObject) {
        //
    }
    
    func openMeterValues(_ meterId: MeterId) {
        //
    }
    
    func openPropertyObjectSettings(_ propertyObjectId: PropertyObjectId) {
        //
    }
    
    func openGenerateBill(_ propertyObjectId: PropertyObjectId) {
        //
    }
}

func _propertyObjectViewModelMock() -> PropertyObjectViewModel {
    let flow = PropertyObjectFlowMock()
    let viewModel = PropertyObjectViewModel(
        UUID(),
        flow: flow
    )
    return viewModel
}
#endif
