//
//  UpdatePublisherMock.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

#if DEBUG
import Combine
import Foundation

class UpdatePublisherMock: UpdatePublisher {
    var publisher: AnyPublisher<(), Never> {
        Empty().eraseToAnyPublisher()
    }
}
#endif
