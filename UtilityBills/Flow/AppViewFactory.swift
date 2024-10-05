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
    
    func addMeterValueView(_ meterId: MeterId, flowDelegate: ManageMeterValueFlowDelegate) -> AnyView
    
    func editMeterValueView(_ meterValue: MeterValue, flowDelegate: ManageMeterValueFlowDelegate) -> AnyView
    
    func addMeterView(_ propObjId: PropertyObjectId, flowDelegate: ManageMeterFlowDelegate) -> AnyView
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
    
    func addMeterValueView(_ meterId: MeterId, flowDelegate: ManageMeterValueFlowDelegate) -> AnyView {
        let viewModel = MeterValueViewModel(
            meterId: meterId,
            date: Date(),
            value: 0,
            flow: flowDelegate
        )
        let view = MeterValueView(viewModel: viewModel)
        return AnyView(view)
    }
    
    func editMeterValueView(_ meterValue: MeterValue, flowDelegate: ManageMeterValueFlowDelegate) -> AnyView {
        let viewModel = MeterValueViewModel(
            meterValue: meterValue,
            flow: flowDelegate
        )
        let view = MeterValueView(viewModel: viewModel)
        return AnyView(view)
    }
    
    func addMeterView(_ propObjId: PropertyObjectId, flowDelegate: ManageMeterFlowDelegate) -> AnyView {
        let vm = AddMeterViewModel(
            propertyObjectId: propObjId,
            flow: flowDelegate
        )
        let view = AddMeterView(viewModel: vm)
        return AnyView(view)
    }
}
