//
//  IssuesListPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol IssuesListPresenter {
    var issueCellPresenter: IssueCellPresenter { get }
    var emptyListMessage: String { get }
    var screenTitle: String { get }
}
