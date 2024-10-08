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
        case .meter(let meter):
            MeterIssueView(meter: meter)
        }
    }
}

struct MeterIssueView: View {
    let meter: Meter
    
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
    
    private var title: String {
        "Meter \"\(meter.name)\""
    }
    
    var body: some View {
        HStack {
            Text(title)
                .lineLimit(1)
            Spacer()
            Text(message)
                .foregroundColor(messageColor)
                .lineLimit(1)
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
    let issue = Issue.meter(meter)
    return IssueView(issue: issue)
}
