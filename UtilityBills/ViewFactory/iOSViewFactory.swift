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
        let cardPresenter = iOSHomeCardPresenter()
        let presenter = iOSPropertiesPresenter(cardPresenter: cardPresenter)        
        let view = PropertiesView(
            viewModel: viewModel,
            presenter: presenter
        )
        return ViewHolder(view)
    }
    
    func propertyHomeView(_ propObjId: PropertyObjectId, flowDelegate: PropertyObjectFlowDelegate) -> ViewHolder {
        let viewModel = PropertyObjectViewModel(
            propObjId,
            flow: flowDelegate
        )
        let billCellPresenter = iOSBillCellPresenter()
        let presenter = iOSPropertyObjectPresenter(billCellPresenter: billCellPresenter)
        let view = PropertyObjectView(
            viewModel: viewModel,
            presenter: presenter
        )
        return ViewHolder(view)
    }
    
    func issuesListView(flowDelegate: IssuesFlowDelegate) -> ViewHolder {
        let viewModel = IssuesListViewModel(flow: flowDelegate)
        let issueCellPresenter = iOSIssueCellPresenter()
        let presenter = iOSIssuesListPresenter(issueCellPresenter: issueCellPresenter)
        let view = IssuesListView(
            viewModel: viewModel,
            presenter: presenter
        )
        return ViewHolder(view)
    }
    
    func createPropertyObjectView(flowDelegate: CreatePropertyObjectFlowDelegate) -> ViewHolder {
        let viewModel = ManagePropertyObjectViewModel(
            createFlow: flowDelegate
        )
        let presenter = CreateManagePropertyObjectPresenter()
        let view = ManagePropertyObjectView(viewModel: viewModel, presenter: presenter)
        return ViewHolder(view)
    }

    func updatePropertyObjectView(_ propObjId: PropertyObject, flowDelegate: UpdatePropertyObjectFlowDelegate) -> ViewHolder {
        let viewModel = ManagePropertyObjectViewModel(
            propertyObject: propObjId,
            updateFlow: flowDelegate
        )
        let presenter = UpdateManagePropertyObjectPresenter()
        let view = ManagePropertyObjectView(
            viewModel: viewModel,
            presenter: presenter
        )
        return ViewHolder(view)
    }
    
    func billsListView(_ propObjId: PropertyObjectId, flowDelegate: BillListFlowDelegate) -> ViewHolder {
        let viewModel = BillListViewModel(flowDelegate: flowDelegate)
        let billCellPresenter = iOSBillCellPresenter()
        let presenter = iOSBillListPresenter(billCellPresenter: billCellPresenter)
        let view = BillListView(
            viewModel: viewModel,
            presenter: presenter
        )
        return ViewHolder(view)
    }
    
    func billDetailsView(_ bill: Bill) -> ViewHolder {
        let viewModel = BillDetailsViewModel(bill)
        let view = BillDetailsView(
            viewModel: viewModel,
            presenter: iOSBillDetailsPresenter()
        )
        return ViewHolder(view)
    }
    
    func propertyObjectSettingsView(_ propObjId: PropertyObjectId, flowDelegate: PropertyObjectSettingFlowDelegate) -> ViewHolder {
        let viewModel = PropertySettingsViewModel(
            objectId: propObjId,
            flow: flowDelegate
        )
        let alertPresenter = DeletePropertyObjectAlertPresenter()
        let presenter = iOSPropertySettingsPresenter(deleteAlertPresenter: alertPresenter)
        let view = PropertySettingsView(
            viewModel: viewModel,
            presenter: presenter
        )
        return ViewHolder(view)
    }
    
    func meterValuesView(_ meterId: MeterId, flowDelegate: MeterValuesListFlowDelegate) -> ViewHolder {
        let viewModel = MeterValuesListViewModel(
            meterId: meterId,
            flow: flowDelegate
        )
        let presenter = iOSMeterValuesListPresenter()
        let view = MeterValuesListView(viewModel: viewModel, presenter: presenter)
        return ViewHolder(view)
    }
    
    func addMeterValueView(_ meterId: MeterId, flowDelegate: ManageMeterValueFlowDelegate) -> ViewHolder {
        let viewModel = MeterValueViewModel(
            meterId: meterId,
            date: Date(),
            value: 0,
            flow: flowDelegate
        )
        let presenter = AddMeterValuePresenter()
        let view = MeterValueView(viewModel: viewModel, presenter: presenter)
        return ViewHolder(view)
    }
    
    func editMeterValueView(_ meterValue: MeterValue, flowDelegate: ManageMeterValueFlowDelegate) -> ViewHolder {
        let viewModel = MeterValueViewModel(
            meterValue: meterValue,
            flow: flowDelegate
        )
        let presenter = EditMeterValuePresenter()
        let view = MeterValueView(viewModel: viewModel, presenter: presenter)
        return ViewHolder(view)
    }
    
    func addMeterView(_ propObjId: PropertyObjectId, flowDelegate: ManageMeterFlowDelegate) -> ViewHolder {
        let vm = AddMeterViewModel(
            propertyObjectId: propObjId,
            flow: flowDelegate
        )
        let presenter = iOSAddMeterPresenter()
        let view = AddMeterView(viewModel: vm, presenter: presenter)
        return ViewHolder(view)
    }
    
    func editMeterView(_ meter: Meter, flowDelegate: ManageMeterFlowDelegate) -> ViewHolder {
        let viewModel = EditMeterViewModel(
            meter: meter,
            flow: flowDelegate
        )
        let alertPresenter = DeleteMeterAlertPresenter()
        let presenter = iOSEditMeterPresenter(deleteMeterAlertPresenter: alertPresenter)
        let view = EditMeterView(viewModel: viewModel, presenter: presenter)
        return ViewHolder(view)
    }
    
    func addTariffView(_ propObjId: PropertyObjectId, flowDelegate: ManageTariffFlowDelegate) -> ViewHolder {
        let viewModel = ManageTariffViewModel(
            propertyObjectId: propObjId,
            flow: flowDelegate
        )
        let alertPresenter = DeleteTariffAlertPresenter()
        let presenter = iOSManageTariffPresenter(
            mode: .add,
            deleteTariffAlertPresenter: alertPresenter
        )
        let view = ManageTariffView(viewModel: viewModel, presenter: presenter)
        return ViewHolder(view)
    }
    
    func editTariffView(_ tariff: Tariff, flowDelegate: ManageTariffFlowDelegate) -> ViewHolder {
        let viewModel = ManageTariffViewModel(
            tariff: tariff,
            flow: flowDelegate
        )
        let alertPresenter = DeleteTariffAlertPresenter()
        let presenter = iOSManageTariffPresenter(
            mode: .edit,
            deleteTariffAlertPresenter: alertPresenter
        )
        let view = ManageTariffView(viewModel: viewModel, presenter: presenter)

        return ViewHolder(view)
    }
    
    func addBillingMapView(_ billingMapData: BillingMapData, flowDelegate: ManageBillingMapFlowDelegate) -> ViewHolder {
        let viewModel = BillingMapViewModel(
            billingMapData: billingMapData,
            flow: flowDelegate
        )
        let presenter = iOSBillingMapPresenter()
        let view = BillingMapView(viewModel: viewModel, presenter: presenter)
        return ViewHolder(view)
    }
    
    func editBillingMapView(_ billingMap: BillingMap, billingMapData: BillingMapData, flowDelegate: ManageBillingMapFlowDelegate) -> ViewHolder {
        let viewModel = BillingMapViewModel(
            billingMap: billingMap,
            billingMapData: billingMapData,
            flow: flowDelegate
        )
        let presenter = iOSBillingMapPresenter()
        let view = BillingMapView(viewModel: viewModel, presenter: presenter)
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
