//
//  DefaultAlertErrorPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

struct DefaultAlertErrorPresenter: AlertErrorPresenter {
    //
}

extension AlertErrorPresenter {
    func errorAlertTitle(_ error: Error?) -> String {
        "Error"
    }
    
    func errorAlertMessage(_ error: Error?) -> String {
        error?.localizedDescription ??  "Something went wrong"
    }
    
    var dismissButtonTitle: String {
        "Dismiss"
    }
}
