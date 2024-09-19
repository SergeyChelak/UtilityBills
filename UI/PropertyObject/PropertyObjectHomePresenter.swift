//
//  PropertyObjectHomePresenter.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import Foundation

protocol PropertyObjectHomePresenter {
    var title: String { get }
    
    var propertyInfoSectionTitle: String { get }
    
    var propertyInfoEditButtonTitle: String? { get }
    
    var propertyInfoEditButtonImageDescriptor: ImageDescriptor? { get }
    
    var metersSectionTitle: String { get }
    
    var metersAddButtonTitle: String? { get }
    
    var metersAddButtonImageDescriptor: ImageDescriptor? { get }
}
