//
//  StorageWatcher.swift
//  UtilityBills
//
//  Created by Sergey on 10.09.2024.
//

import Combine
import Foundation

class StorageWatcher {
    private var cancellables: Set<AnyCancellable> = []
    let _publisher = PassthroughSubject<(), Never>()
    
    init(storage: LocalStorage) {
        NotificationCenter.default
            .publisher(for: Notification.Name.NSManagedObjectContextObjectsDidChange)
            .filter {
                $0.object as? AnyObject === storage.viewContext
            }
            .receive(on: DispatchQueue.main)
            .sink { notification in
                self._publisher.send()
            }
            .store(in: &cancellables)
    }
    
    var publisher: AnyPublisher<(), Never> {
        _publisher.eraseToAnyPublisher()
    }
}
