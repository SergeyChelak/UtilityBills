//
//  MeterValuesListPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol MeterValuesListPresenter {
    var screenTitle: String { get }
    var emptyListMessage: String { get }
    var addButtonTitle: String { get }
    // TODO: create separate presenter
    func cellCaption(_ value: MeterValue) -> String
    func cellValue(_ value: MeterValue) -> String
}
