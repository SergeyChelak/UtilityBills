//
//  PropertyObjectPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

struct iOSPropertyObjectPresenter: PropertyObjectPresenter {
    func screenTitle(_ propertyObject: PropertyObject?) -> String {
        propertyObject?.name ?? ""
    }
    
    var sectionMetersTitle: String {
        "Meters"
    }
    
    var sectionBillsTitle: String {
        "Bills"
    }
    
    var sectionBillsActionViewAllTitle: String {
        "View all"
    }
    
    var buttonGenerateTitle: String {
        "Generate bill"
    }
    
    var propertySettingsIcon: ImageHolder {
        ImageHolder(type: .system, name: "gearshape")
    }
}

struct iOSBillCellPresenter: BillCellPresenter {
    func title(_ bill: Bill) -> String {
        bill.date.formatted()
    }
    
    func value(_ bill: Bill) -> String {
        bill.total.formatted()
    }
}
