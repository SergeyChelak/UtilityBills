//
//  IssueView.swift
//  UtilityBills
//
//  Created by Sergey on 08.10.2024.
//

import SwiftUI

struct IssueView: View {
    let issue: Issue
    
    var body: some View {
        switch issue {
        case .meter(let data):
            MeterIssueView(fullMeterData: data)
        }
    }
}

struct MeterIssueView: View {
    let fullMeterData: FullMeterData
    
    private var meter: Meter {
        fullMeterData.meter
    }
    
    private var message: String {
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
    
    private var messageColor: Color {
        switch meter.getInspectionState() {
        case .expiring:
                .yellow
        case .overdue:
                .red
        case .normal:
                .black
        }
    }
    
    private var objectName: String {
        fullMeterData.propertyObject.name
    }
    
    private var title: String {
        "Meter \"\(meter.name)\" of \"\(objectName)\""
    }
    
    var body: some View {
        VStack {
            Text(title)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(message)
                .font(.headline)
                .foregroundColor(messageColor)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .contentShape(Rectangle())

    }
}

#Preview {
    let meter = Meter(
        id: MeterId(),
        name: "meter",
        capacity: 10,
        inspectionDate: Date()
    )
    let obj = _propertyObject()
    let fullData = FullMeterData(propertyObject: obj, meter: meter)
    let issue = Issue.meter(fullData)
    return IssueView(issue: issue)
}
