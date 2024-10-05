//
//  DirtyBillStorage.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Combine
import Foundation

class DirtyBillStorage {
    private let updatePublisher = PassthroughSubject<(), Never>()
    private var rawItems: [BillRecord]?
    
    var items: [BillRecord] {
        rawItems ?? []
    }
    
    var hasData: Bool {
        rawItems != nil
    }
    
    func setRecords(_ items: [BillRecord]) {
        self.rawItems = items
//        notify()
    }
    
    func update(_ item: BillRecord) {
        guard let index = rawItems?.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        self.rawItems?[index] = item
        notify()
    }
    
    func delete(_ itemId: BillRecordId) {
        rawItems?.removeAll {
            $0.id == itemId
        }
        notify()
    }
    
    private func notify() {
        updatePublisher.send()
    }
}

extension DirtyBillStorage: UpdatePublisher {
    var publisher: AnyPublisher<(), Never> {
        updatePublisher.eraseToAnyPublisher()
    }
}
