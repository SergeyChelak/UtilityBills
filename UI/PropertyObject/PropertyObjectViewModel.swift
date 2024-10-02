//
//  PropertyObjectViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 22.09.2024.
//

import Combine
import Foundation

typealias PropertyObjectActionLoad = () throws -> PropertyObjectData
typealias PropertyObjectActionInfoSectionTap = (PropertyObject) -> Void
typealias PropertyObjectActionMeterSelectionTap = (MeterId) -> Void
typealias PropertyObjectActionSettings = () -> Void
typealias PropertyObjectActionGenerateBill = (PropertyObjectId) -> Void


class PropertyObjectViewModel: ViewModel {
    private var cancellables: Set<AnyCancellable> = []
    
    let objectId: PropertyObjectId

    private let actionLoad: PropertyObjectActionLoad
    private let actionInfoSectionTap: PropertyObjectActionInfoSectionTap
    private let actionMeterSelectionTap: PropertyObjectActionMeterSelectionTap
    private let actionSettings: PropertyObjectActionSettings
    private let actionGenerateBill: PropertyObjectActionGenerateBill
    
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
        actionLoad: @escaping PropertyObjectActionLoad,
        actionInfoSectionTap: @escaping PropertyObjectActionInfoSectionTap,
        actionMeterSelectionTap: @escaping PropertyObjectActionMeterSelectionTap,
        actionSettings: @escaping PropertyObjectActionSettings,
        actionGenerateBill: @escaping PropertyObjectActionGenerateBill,
        updatePublisher: AnyPublisher<(), Never>
    ) {
        self.objectId = objectId
        self.actionLoad = actionLoad
        self.actionInfoSectionTap = actionInfoSectionTap
        self.actionMeterSelectionTap = actionMeterSelectionTap
        self.actionSettings = actionSettings
        self.actionGenerateBill = actionGenerateBill
        super.init()
        updatePublisher
            .sink(receiveValue: load)
            .store(in: &cancellables)
    }
    
    func load() {
        do {
            data = try actionLoad()
        } catch {
            setError(error)
        }
    }
    
    func infoSectionSelected() {
        guard let propObj = data?.propObj else {
            self.error = UtilityBillsError.loadingFailure
            return
        }
        actionInfoSectionTap(propObj)
    }
    
    func meterSelected(_ meter: Meter) {
        actionMeterSelectionTap(meter.id)
    }
        
    func openSettings() {
        actionSettings()
    }
    
    func generateBill() {
        actionGenerateBill(objectId)
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

