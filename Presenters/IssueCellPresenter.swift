//
//  IssueCellPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation
import SwiftUI

protocol IssueCellPresenter {
    func meterIssueTitle(_ data: FullMeterData) -> String
    func meterIssueMessage(_ data: FullMeterData) -> String
    func meterIssueColor(_ data: FullMeterData) -> Color
}
