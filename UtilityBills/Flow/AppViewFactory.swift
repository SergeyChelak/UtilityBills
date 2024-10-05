//
//  AppViewFactory.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Foundation
import SwiftUI

protocol AppViewFactory {
    func propertyObjectListView(delegateFlow: PropertyObjectListFlowDelegate) -> AnyView
    
    func propertyHomeView(_ propObjId: PropertyObjectId, flowDelegate: PropertyObjectFlowDelegate) -> AnyView
    
    func editPropertyInfoView(_ obj: PropertyObject, flowDelegate: EditPropertyInfoFlowDelegate) -> AnyView
    
    func meterValuesView(_ meterId: MeterId, flowDelegate: MeterValuesListFlowDelegate) -> AnyView
}

struct iOSViewFactory: AppViewFactory {
    func propertyObjectListView(delegateFlow: PropertyObjectListFlowDelegate) -> AnyView {
        let viewModel = PropertyListViewModel(
            flow: delegateFlow
        )
        let view = PropertyListView(viewModel: viewModel)
        return AnyView(view)
    }
    
    func propertyHomeView(_ propObjId: PropertyObjectId, flowDelegate: PropertyObjectFlowDelegate) -> AnyView {
        let viewModel = PropertyObjectViewModel(
            propObjId,
            flow: flowDelegate
        )
        let view = PropertyObjectView(viewModel: viewModel)
        return AnyView(view)
    }

    func editPropertyInfoView(_ obj: PropertyObject, flowDelegate: EditPropertyInfoFlowDelegate) -> AnyView {
        let viewModel = EditPropertyInfoViewModel(
            propertyObject: obj,
            flow: flowDelegate
        )
        let view = EditPropertyInfoView(viewModel: viewModel)
        return AnyView(view)
    }
    
    func meterValuesView(_ meterId: MeterId, flowDelegate: MeterValuesListFlowDelegate) -> AnyView {
        let viewModel = MeterValuesListViewModel(
            meterId: meterId,
            flow: flowDelegate
        )
        let view = MeterValuesListView(viewModel: viewModel)
        return AnyView(view)
    }
}
