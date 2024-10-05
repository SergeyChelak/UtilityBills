//
//  iOSAppFlowFactory.swift
//  UtilityBills
//
//  Created by Sergey on 03.10.2024.
//

import Foundation

final class iOSAppFlowFactory {
    let storage: LocalStorage
    let router: Router
    let updatePublisher: UpdatePublisher
        
    init(
        router: Router,
        storage: LocalStorage,
        updatePublisher: UpdatePublisher
    ) {
        self.router = router
        self.storage = storage
        self.updatePublisher = updatePublisher
    }

    private lazy var appFlow: iOSAppFlow = {
        iOSAppFlow(
            router: router,
            storage: storage,
            updatePublisher: updatePublisher
        )
    }()
    
    func getPropertyObjectListFlow() -> PropertyObjectListFlowDelegate {
        appFlow
    }
    
    func getPropertyObjectFlow() -> PropertyObjectFlowDelegate {
        appFlow
    }
    
    func getEditPropertyInfoFlow() -> EditPropertyInfoFlowDelegate {
        appFlow
    }
    
    func getManageMeterFlow() -> ManageMeterFlowDelegate {
        appFlow
    }
    
    func getMeterValuesListFlow() -> MeterValuesListFlowDelegate {
        appFlow
    }
    
    func getManageMeterValueFlow() -> ManageMeterValueFlowDelegate {
        appFlow
    }
    
    func getManageTariffFlow() -> ManageTariffFlow {
        appFlow
    }
    
    func getPropertyObjectSettingFlow() -> PropertyObjectSettingFlow {
        appFlow
    }
    
    func getManageBillingMapFlow() -> ManageBillingMapFlow {
        appFlow
    }
    
    func getCalculateFlow(_ propertyObjectId: PropertyObjectId) -> CalculateFlow {
        iOSCalculateFlow(
            router: router,
            storage: storage,
            updatePublisher: updatePublisher,
            propertyObjectId: propertyObjectId
        )
    }
}
