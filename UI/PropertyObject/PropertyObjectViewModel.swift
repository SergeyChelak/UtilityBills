//
//  PropertyObjectViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 22.09.2024.
//

import Combine
import Foundation

class PropertyObjectViewModel: ViewModel {
    private var cancellables: Set<AnyCancellable> = []
    
    let objectId: PropertyObjectId
    private var flow: PropertyObjectFlowDelegate?

    @Published 
    var data: PropertyObjectData?

    var propObj: PropertyObject? {
        data?.propObj
    }
    
    var meters: [Meter] {
        data?.meters ?? []
    }
    
    var bills: [Bill] {
        data?.bills ?? []
    }
    
    init(
        _ objectId: PropertyObjectId,
        flow: PropertyObjectFlowDelegate?
    ) {
        self.objectId = objectId
        self.flow = flow
        super.init()
        flow?.updatePublisher
            .publisher
            .sink(receiveValue: load)
            .store(in: &cancellables)
    }
    
    func load() {
        do {
            data = try flow?.loadPropertyObjectData(objectId)
        } catch {
            setError(error)
        }
    }
    
    func meterSelected(_ meter: Meter) {
        flow?.openMeterValues(meter.id)
    }
        
    func openSettings() {
        flow?.openPropertyObjectSettings(objectId)
    }
    
    func generateBill() {
        flow?.openGenerateBill(objectId)
    }
    
    func billSelected(_ bill: Bill) {
        flow?.openBillDetails(bill)
    }
    
    func viewAllBills() {
        flow?.openBillList(objectId)
    }
}

