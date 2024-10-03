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
    private var flow: PropertyObjectFlow?

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
        flow: PropertyObjectFlow?
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
    
    func infoSectionSelected() {
        guard let propObj = data?.propObj else {
            self.error = UtilityBillsError.loadingFailure
            return
        }
        flow?.openEditPropertyObject(propObj)
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
        setError(UtilityBillsError.notImplemented("billSelected"))
        print("Not implemented: billSelected")
    }
    
    func viewAllBills() {
        setError(UtilityBillsError.notImplemented("viewAllBills"))
        print("Not implemented: viewAllBills")
    }
}

