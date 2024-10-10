//
//  IssuesPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation
import SwiftUI

struct iOSIssuesListPresenter: IssuesListPresenter {
    var emptyListMessage: String {
        "It looks like everything is ok"
    }
    
    var screenTitle: String {
        "Issues"
    }
}

struct iOSIssueCellPresenter: IssueCellPresenter {
    func meterIssueTitle(_ data: FullMeterData) -> String {
        let meter = data.meter
        let objectName = data.propertyObject.name
        return "Meter \"\(meter.name)\" of \"\(objectName)\""
    }
    
    func meterIssueMessage(_ data: FullMeterData) -> String {
        let meter = data.meter
        guard let date = meter.inspectionDate else {
            return ""
        }
        let value = date.formatted()
        return switch meter.getInspectionState() {
        case .expiring:
            "will expire at \(value)"
        case .overdue:
            "expired at \(value)"
        case .normal:
            "ok"
        }
    }
    
    func meterIssueColor(_ data: FullMeterData) -> Color {
        let meter = data.meter
        return switch meter.getInspectionState() {
        case .expiring:
                .yellow
        case .overdue:
                .red
        case .normal:
                .black
        }
    }
}
