//
//  StorageWatcher.swift
//  UtilityBills
//
//  Created by Sergey on 10.09.2024.
//

import Combine
import Foundation

protocol UpdatePublisher {
    var publisher: AnyPublisher<(), Never> { get }
}

// TODO: this is temporary solution to notify view models about managed context changes
class StorageWatcher: UpdatePublisher {
    private var cancellables: Set<AnyCancellable> = []
    let _publisher = PassthroughSubject<(), Never>()
    
    init(storage: LocalStorage) {
        NotificationCenter.default
            .publisher(for: Notification.Name.NSManagedObjectContextObjectsDidChange)
            .filter {
                $0.object as? AnyObject === storage.viewContext
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] notification in
                self?._publisher.send()
            }
            .store(in: &cancellables)
    }
    
    var publisher: AnyPublisher<(), Never> {
        _publisher.eraseToAnyPublisher()
    }
}
