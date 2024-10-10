//
//  PropertiesPresenters.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

struct iOSPropertiesPresenter: PropertiesPresenter {
    let cardPresenter: HomeCardPresenter
    
    var screenTitle: String {
        "My Objects"
    }
    
    var gridWidth: CGFloat {
        150
    }
    
    var gridHeight: CGFloat {
        130
    }
    
    var issuesIcon: ImageHolder {
        ImageHolder(type: .system, name: "bell")
    }
}

struct iOSHomeCardPresenter: HomeCardPresenter {
    func cardTitle(_ card: HomeCard) -> String {
        switch card {
        case .propertyObject(let propertyObject):
            propertyObject.name
        case .addNewObjectAction:
            "New"
        }
    }
    
    func cardSubtitle(_ card: HomeCard) -> String {
        switch card {
        case .propertyObject(let propertyObject):
            propertyObject.details
        case .addNewObjectAction:
            "Tap to add new property object"
        }
    }
    
    func cardImage(_ card: HomeCard) -> ImageHolder {
        switch card {
        case .propertyObject:
            ImageHolder(type: .system, name: "house.fill")
        case .addNewObjectAction:
            ImageHolder(type: .system, name: "plus.circle")
        }
    }
}
