//
//  ViewFactory.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Foundation

protocol ViewFactory {
    func propertyObjectListView(delegateFlow: PropertyObjectListFlowDelegate) -> ViewHolder
    
    func propertyHomeView(_ propObjId: PropertyObjectId, flowDelegate: PropertyObjectFlowDelegate) -> ViewHolder
    
    func issuesListView(flowDelegate: IssuesFlowDelegate) -> ViewHolder
    
    func createPropertyObjectView(flowDelegate: CreatePropertyObjectFlowDelegate) -> ViewHolder
    
    func updatePropertyObjectView(_ propObjId: PropertyObject, flowDelegate: UpdatePropertyObjectFlowDelegate) -> ViewHolder
    
    func propertyObjectSettingsView(_ propObjId: PropertyObjectId, flowDelegate: PropertyObjectSettingFlowDelegate) -> ViewHolder
    
    func meterValuesView(_ meterId: MeterId, flowDelegate: MeterValuesListFlowDelegate) -> ViewHolder
    
    func billsListView(_ propObjId: PropertyObjectId, flowDelegate: BillListFlowDelegate) -> ViewHolder
    
    func billDetailsView(_ bill: Bill) -> ViewHolder
    
    func addMeterValueView(_ meterId: MeterId, flowDelegate: ManageMeterValueFlowDelegate) -> ViewHolder
    
    func editMeterValueView(_ meterValue: MeterValue, flowDelegate: ManageMeterValueFlowDelegate) -> ViewHolder
    
    func addMeterView(_ propObjId: PropertyObjectId, flowDelegate: ManageMeterFlowDelegate) -> ViewHolder
    
    func editMeterView(_ meter: Meter, flowDelegate: ManageMeterFlowDelegate) -> ViewHolder
    
    func addTariffView(_ propObjId: PropertyObjectId, flowDelegate: ManageTariffFlowDelegate) -> ViewHolder
    
    func editTariffView(_ tariff: Tariff, flowDelegate: ManageTariffFlowDelegate) -> ViewHolder
    
    func addBillingMapView(_ billingMapData: BillingMapData, flowDelegate: ManageBillingMapFlowDelegate) -> ViewHolder
    
    func editBillingMapView(_ billingMap: BillingMap, billingMapData: BillingMapData, flowDelegate: ManageBillingMapFlowDelegate) -> ViewHolder
    
    func generateBillView(_ propObjId: PropertyObjectId, flowDelegate: CalculateFlowDelegate) -> ViewHolder
    
    func modifyBillRecordView(_ billRecord: BillRecord, flowDelegate: ManageBillRecordFlowDelegate) -> ViewHolder
}
