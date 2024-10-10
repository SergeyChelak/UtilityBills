//
//  HomeCardPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol HomeCardPresenter {
    func cardTitle(_ card: HomeCard) -> String
    func cardSubtitle(_ card: HomeCard) -> String
    func cardImage(_ card: HomeCard) -> ImageHolder
}
