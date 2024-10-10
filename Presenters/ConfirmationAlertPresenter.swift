//
//  ConfirmationAlertPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol ConfirmationAlertPresenter {
    var title: String { get }
    var message: String { get }
    var confirmButtonTitle: String { get }
    var cancelButtonTitle: String { get }
}
