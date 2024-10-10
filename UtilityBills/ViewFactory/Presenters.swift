//
//  Presenters.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation
import SwiftUI

// MARK: PropertiesPresenter
protocol PropertiesPresenter {
    var screenTitle: String { get }
    
    var gridWidth: CGFloat { get }
    var gridHeight: CGFloat { get }
    
    var issuesIcon: ImageHolder { get }
}

// MARK: HomeCardPresenter
protocol HomeCardPresenter {
    func cardTitle(_ card: HomeCard) -> String
    
    func cardSubtitle(_ card: HomeCard) -> String
    
    func cardImage(_ card: HomeCard) -> ImageHolder
}

// MARK: PropertyObjectPresenter
protocol PropertyObjectPresenter {
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
    var emptyListMessage: String { get }
    var screenTitle: String { get }
}

protocol IssueCellPresenter {
    func meterIssueTitle(_ data: FullMeterData) -> String
    func meterIssueMessage(_ data: FullMeterData) -> String
    func meterIssueColor(_ data: FullMeterData) -> Color
}
