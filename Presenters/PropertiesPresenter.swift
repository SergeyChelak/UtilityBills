//
//  PropertiesPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol PropertiesPresenter {
    var cardPresenter: HomeCardPresenter { get }
    var screenTitle: String { get }
    var gridWidth: CGFloat { get }
    var gridHeight: CGFloat { get }
    var issuesIcon: ImageHolder { get }
}
