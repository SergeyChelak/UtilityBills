//
//  PropertySettingsViewModel.swift
//  UtilityBillsTests
//
//  Created by Sergey on 27.09.2024.
//

import Foundation

typealias PropertyObjectActionDelete = () throws -> Void

class PropertySettingsViewModel: ObservableObject {
    let objectId: PropertyObjectId
    private let actionDelete: PropertyObjectActionDelete
    
    @Published
    var error: Error?
    
    init(
        objectId: PropertyObjectId,
        actionDelete: @escaping PropertyObjectActionDelete
    ) {
        self.objectId = objectId
        self.actionDelete = actionDelete
    }
    
    func deleteObject() {
        do {
            try actionDelete()
        } catch {
            self.error = error
        }
    }
}
