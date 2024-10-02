//
//  ViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 30.09.2024.
//

import Foundation

class ViewModel: ObservableObject {
    @Published
    var error: Error?
    
    func setError(_ error: Error) {
        print(error)
        self.error = error
    }
    
    func unexpectedError(_ message: String) {
        let error = UtilityBillsError.unexpectedState(message)
        setError(error)
    }
}
