//
//  PropertyObjectPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol PropertyObjectPresenter {
    var billCellPresenter: BillCellPresenter { get }
    func screenTitle(_ propertyObject: PropertyObject?) -> String
    var sectionMetersTitle: String { get }
    var sectionBillsTitle: String { get }
    var sectionBillsActionViewAllTitle: String { get }
    var buttonGenerateTitle: String { get }
    var propertySettingsIcon: ImageHolder { get }
}
