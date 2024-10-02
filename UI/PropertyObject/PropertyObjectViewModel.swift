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
    private weak var delegate: PropertyObjectFlow?

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
        delegate: PropertyObjectFlow?
    ) {
        self.objectId = objectId
        self.delegate = delegate
        super.init()
        delegate?.updatePublisher
            .publisher
            .sink(receiveValue: load)
            .store(in: &cancellables)
    }
    
    func load() {
        do {
            data = try delegate?.loadPropertyObjectData(objectId)
        } catch {
            setError(error)
        }
    }
    
    func infoSectionSelected() {
        guard let propObj = data?.propObj else {
            self.error = UtilityBillsError.loadingFailure
            return
        }
        delegate?.openEditPropertyObject(propObj)
    }
    
    func meterSelected(_ meter: Meter) {
        delegate?.openMeterValues(meter.id)
    }
        
    func openSettings() {
        delegate?.openPropertyObjectSettings(objectId)
    }
    
    func generateBill() {
        delegate?.openGenerateBill(objectId)
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

