//
//  PropertySettingsViewModel.swift
//  UtilityBillsTests
//
//  Created by Sergey on 27.09.2024.
//

import Foundation

typealias PropertySettingsActionLoadBillingMaps = () throws -> [BillingMap]
typealias PropertySettingsActionDelete = () throws -> Void

class PropertySettingsViewModel: ObservableObject {
    let objectId: PropertyObjectId
    private let actionLoadBillingMaps: PropertySettingsActionLoadBillingMaps
    private let actionDelete: PropertySettingsActionDelete
    
    @Published
    var billingMaps: [BillingMap] = []
    @Published
    var error: Error?
    
    init(
        objectId: PropertyObjectId,
        actionLoad: @escaping PropertySettingsActionLoadBillingMaps,
        actionDelete: @escaping PropertySettingsActionDelete
    ) {
        self.objectId = objectId
        self.actionLoadBillingMaps = actionLoad
        self.actionDelete = actionDelete
    }
    
    func load() {
        do {
            billingMaps = try actionLoadBillingMaps()
        } catch {
            self.error = error
        }
    }
    
    func deleteObject() {
        do {
            try actionDelete()
        } catch {
            self.error = error
        }
    }
}
