//
//  AppViewFactory.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Foundation
import SwiftUI

protocol AppViewFactory {
    func propertyObjectListView(delegateFlow: PropertyObjectListFlowDelegate) -> ViewHolder
    
    func propertyHomeView(_ propObjId: PropertyObjectId, flowDelegate: PropertyObjectFlowDelegate) -> ViewHolder
    
    func editPropertyInfoView(_ obj: PropertyObject, flowDelegate: EditPropertyInfoFlowDelegate) -> ViewHolder
    
    func meterValuesView(_ meterId: MeterId, flowDelegate: MeterValuesListFlowDelegate) -> ViewHolder
    
    func addMeterValueView(_ meterId: MeterId, flowDelegate: ManageMeterValueFlowDelegate) -> ViewHolder
    
    func editMeterValueView(_ meterValue: MeterValue, flowDelegate: ManageMeterValueFlowDelegate) -> ViewHolder
    
    func addMeterView(_ propObjId: PropertyObjectId, flowDelegate: ManageMeterFlowDelegate) -> ViewHolder
}

struct iOSViewFactory: AppViewFactory {
    func propertyObjectListView(delegateFlow: PropertyObjectListFlowDelegate) -> ViewHolder {
        let viewModel = PropertyListViewModel(
            flow: delegateFlow
        )
        let view = PropertyListView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func propertyHomeView(_ propObjId: PropertyObjectId, flowDelegate: PropertyObjectFlowDelegate) -> ViewHolder {
        let viewModel = PropertyObjectViewModel(
            propObjId,
            flow: flowDelegate
        )
        let view = PropertyObjectView(viewModel: viewModel)
        return ViewHolder(view)
    }

    func editPropertyInfoView(_ obj: PropertyObject, flowDelegate: EditPropertyInfoFlowDelegate) -> ViewHolder {
        let viewModel = EditPropertyInfoViewModel(
            propertyObject: obj,
            flow: flowDelegate
        )
        let view = EditPropertyInfoView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func meterValuesView(_ meterId: MeterId, flowDelegate: MeterValuesListFlowDelegate) -> ViewHolder {
        let viewModel = MeterValuesListViewModel(
            meterId: meterId,
            flow: flowDelegate
        )
        let view = MeterValuesListView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func addMeterValueView(_ meterId: MeterId, flowDelegate: ManageMeterValueFlowDelegate) -> ViewHolder {
        let viewModel = MeterValueViewModel(
            meterId: meterId,
            date: Date(),
            value: 0,
            flow: flowDelegate
        )
        let view = MeterValueView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func editMeterValueView(_ meterValue: MeterValue, flowDelegate: ManageMeterValueFlowDelegate) -> ViewHolder {
        let viewModel = MeterValueViewModel(
            meterValue: meterValue,
            flow: flowDelegate
        )
        let view = MeterValueView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func addMeterView(_ propObjId: PropertyObjectId, flowDelegate: ManageMeterFlowDelegate) -> ViewHolder {
        let vm = AddMeterViewModel(
            propertyObjectId: propObjId,
            flow: flowDelegate
        )
        let view = AddMeterView(viewModel: vm)
        return ViewHolder(view)
    }
}
