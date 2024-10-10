//
//  ErrorAlertPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol ErrorAlertPresenter {
    func errorAlertTitle(_ error: Error?) -> String
    func errorAlertMessage(_ error: Error?) -> String
    var dismissButtonTitle: String { get }
}
