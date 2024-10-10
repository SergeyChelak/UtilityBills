//
//  Presenters.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

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
