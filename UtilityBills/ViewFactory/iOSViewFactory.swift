//
//  iOSViewFactory.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Foundation

struct iOSViewFactory: ViewFactory {
    func propertyObjectListView(delegateFlow: PropertyObjectListFlowDelegate) -> ViewHolder {
        let viewModel = PropertiesViewModel(
            flow: delegateFlow
        )
        let presenter = DefaultPropertiesPresenter()
        let cardPresenter = DefaultHomeCardPresenter()
        let view = PropertiesView(
            viewModel: viewModel,
            presenter: presenter,
            cardPresenter: cardPresenter
        )
        return ViewHolder(view)
    }
    
    func propertyHomeView(_ propObjId: PropertyObjectId, flowDelegate: PropertyObjectFlowDelegate) -> ViewHolder {
        let viewModel = PropertyObjectViewModel(
            propObjId,
            flow: flowDelegate
        )
        let view = PropertyObjectView(
            viewModel: viewModel,
            screenPresenter: DefaultPropertyObjectPresenter(),
            billCellPresenter: DefaultBillCellPresenter()
        )
        return ViewHolder(view)
    }
    
    func issuesListView(flowDelegate: IssuesFlowDelegate) -> ViewHolder {
        let viewModel = IssuesListViewModel(flow: flowDelegate)
        let view = IssuesListView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func createPropertyObjectView(flowDelegate: CreatePropertyObjectFlowDelegate) -> ViewHolder {
        let viewModel = ManagePropertyObjectViewModel(
            createFlow: flowDelegate
        )
        let view = ManagePropertyObjectView(viewModel: viewModel)
        return ViewHolder(view)
    }

    func updatePropertyObjectView(_ propObjId: PropertyObject, flowDelegate: UpdatePropertyObjectFlowDelegate) -> ViewHolder {
        let viewModel = ManagePropertyObjectViewModel(
            propertyObject: propObjId,
            updateFlow: flowDelegate
        )
        let view = ManagePropertyObjectView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func billsListView(_ propObjId: PropertyObjectId, flowDelegate: BillListFlowDelegate) -> ViewHolder {
        let viewModel = BillListViewModel(flowDelegate: flowDelegate)
        let view = BillListView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func billDetailsView(_ bill: Bill) -> ViewHolder {
        let viewModel = BillDetailsViewModel(bill)
        let view = BillDetailsView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func propertyObjectSettingsView(_ propObjId: PropertyObjectId, flowDelegate: PropertyObjectSettingFlowDelegate) -> ViewHolder {
        let viewModel = PropertySettingsViewModel(
            objectId: propObjId,
            flow: flowDelegate
        )
        let view = PropertySettingsView(viewModel: viewModel)
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
    
    func editMeterView(_ meter: Meter, flowDelegate: ManageMeterFlowDelegate) -> ViewHolder {
        let viewModel = EditMeterViewModel(
            meter: meter,
            flow: flowDelegate
        )
        let view = EditMeterView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func addTariffView(_ propObjId: PropertyObjectId, flowDelegate: ManageTariffFlowDelegate) -> ViewHolder {
        let viewModel = ManageTariffViewModel(
            propertyObjectId: propObjId,
            flow: flowDelegate
        )
        let view = ManageTariffView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func editTariffView(_ tariff: Tariff, flowDelegate: ManageTariffFlowDelegate) -> ViewHolder {
        let viewModel = ManageTariffViewModel(
            tariff: tariff,
            flow: flowDelegate
        )
        let view = ManageTariffView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func addBillingMapView(_ billingMapData: BillingMapData, flowDelegate: ManageBillingMapFlowDelegate) -> ViewHolder {
        let viewModel = BillingMapViewModel(
            billingMapData: billingMapData,
            flow: flowDelegate
        )
        let view = BillingMapView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func editBillingMapView(_ billingMap: BillingMap, billingMapData: BillingMapData, flowDelegate: ManageBillingMapFlowDelegate) -> ViewHolder {
        let viewModel = BillingMapViewModel(
            billingMap: billingMap,
            billingMapData: billingMapData,
            flow: flowDelegate
        )
        let view = BillingMapView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func generateBillView(_ propObjId: PropertyObjectId, flowDelegate: CalculateFlowDelegate) -> ViewHolder {
        let viewModel = GenerateBillViewModel(
            propertyObjectId: propObjId,
            flow: flowDelegate
        )
        let view = GenerateBillView(viewModel: viewModel)
        return ViewHolder(view)
    }
    
    func modifyBillRecordView(_ billRecord: BillRecord, flowDelegate: ManageBillRecordFlowDelegate) -> ViewHolder {
        let vm = ModifyBillRecordViewModel(
            billRecord: billRecord,
            flow: flowDelegate
        )
        let view = ModifyBillRecordView(viewModel: vm)
        return ViewHolder(view)
    }
}
