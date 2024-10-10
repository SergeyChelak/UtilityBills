//
//  IssueView.swift
//  UtilityBills
//
//  Created by Sergey on 08.10.2024.
//

import SwiftUI

struct IssueView: View {
    let issue: Issue
    let presenter: IssueCellPresenter
    
    
    var body: some View {
        switch issue {
        case .meter(let data):
            meterIssueView(data)
        }
    }
    
    private func meterIssueView(_ data: FullMeterData) -> some View {
        let title = presenter.meterIssueTitle(data)
        let message = presenter.meterIssueMessage(data)
        let color = presenter.meterIssueColor(data)
        return MeterIssueView(title: title, message: message, messageColor: color)
    }
}

struct MeterIssueView: View {
    let title: String
    let message: String
    let messageColor: Color
    
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
    return IssueView(
        issue: issue,
        presenter: iOSIssueCellPresenter()
    )
}
