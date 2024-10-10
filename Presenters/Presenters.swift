//
//  Presenters.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation
import SwiftUI

// MARK: PropertyObjectPresenter
protocol PropertyObjectPresenter {
    var billCellPresenter: BillCellPresenter { get }
    func screenTitle(_ propertyObject: PropertyObject?) -> String
    var sectionMetersTitle: String { get }
    var sectionBillsTitle: String { get }
    var sectionBillsActionViewAllTitle: String { get }
    var buttonGenerateTitle: String { get }
    var propertySettingsIcon: ImageHolder { get }
}

// MARK: BillCellPresenter
protocol BillCellPresenter {
    func title(_ bill: Bill) -> String     
    func value(_ bill: Bill) -> String
}

protocol IssuesListPresenter {
    var issueCellPresenter: IssueCellPresenter { get }
    var emptyListMessage: String { get }
    var screenTitle: String { get }
}

protocol IssueCellPresenter {
    func meterIssueTitle(_ data: FullMeterData) -> String
    func meterIssueMessage(_ data: FullMeterData) -> String
    func meterIssueColor(_ data: FullMeterData) -> Color
}

protocol ManagePropertyObjectPresenter: ControlButtonsPresenter {
    var header: String { get }
    var objectNameInputFieldTitle: String { get }
    var objectDetailsInputFieldTitle: String { get }
}

protocol ControlButtonsPresenter {
    func actionName(_ action: ControlAction) -> String
}

protocol BillListPresenter {
    var billCellPresenter: BillCellPresenter { get }
    var emptyBillListMessage: String { get }
    var screenTitle: String { get }
}

protocol BillDetailsPresenter {
    var header: String { get }
    var emptyBillMessage: String { get }
    func totalPrice(_ price: Decimal) -> String
    func billDate(_ date: Date) -> String
}
