//
//  ManagePropertyObjectPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol ManagePropertyObjectPresenter: ControlButtonsPresenter {
    var header: String { get }
    var objectNameInputFieldTitle: String { get }
    var objectDetailsInputFieldTitle: String { get }
}
