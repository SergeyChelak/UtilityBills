//
//  iOSAppViewFactory.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import Foundation
import SwiftUI
import Combine

struct iOSAppViewFactory {
    private let flowFactory: iOSAppFlowFactory
    
    init(flowFactory: iOSAppFlowFactory) {
        self.flowFactory = flowFactory
    }
    
    private func composePropertyObjectListView() -> some View {
        let viewModel = PropertyListViewModel(
            flow: flowFactory.getPropertyObjectListFlow()
        )
        return PropertyListView(viewModel: viewModel)
    }
    
    private func composePropertyHomeView(_ propObjId: PropertyObjectId) -> some View {
        let viewModel = PropertyObjectViewModel(
            propObjId,
            flow: flowFactory.getPropertyObjectFlow()
        )
        return PropertyObjectView(viewModel: viewModel)
    }
    
    private func composeEditPropertyInfoView(_ obj: PropertyObject) -> some View {
        let viewModel = EditPropertyInfoViewModel(
            propertyObject: obj,
            flow: flowFactory.getEditPropertyInfoFlow()
        )
        return EditPropertyInfoView(viewModel: viewModel)
    }
    
    private func composeAddMeterView(_ propObjId: PropertyObjectId) -> some View {
        let vm = AddMeterViewModel(
            propertyObjectId: propObjId,
            flow: flowFactory.getManageMeterFlow()
        )
        return AddMeterView(viewModel: vm)
    }
    
    private func composeMeterValuesView(_ meterId: MeterId) -> some View {
        let viewModel = MeterValuesListViewModel(
            meterId: meterId,
            flow: flowFactory.getMeterValuesListFlow()
        )
        return MeterValuesListView(viewModel: viewModel)
    }
    
    private func composeAddMeterValueView(_ meterId: MeterId) -> some View {
        let viewModel = MeterValueViewModel(
            meterId: meterId,
            date: Date(),
            value: 0,
            flow: flowFactory.getManageMeterValueFlow()
        )
        return MeterValueView(viewModel: viewModel)
    }
    
    private func composeEditMeterValueView(_ meterValue: MeterValue) -> some View {
        let viewModel = MeterValueViewModel(
            meterValue: meterValue,
            flow: flowFactory.getManageMeterValueFlow()
        )
        return MeterValueView(viewModel: viewModel)
    }
    
    private func composeAddTariffView(_ propObjId: PropertyObjectId) -> some View {
        let viewModel = ManageTariffViewModel(
            propertyObjectId: propObjId,
            flow: flowFactory.getManageTariffFlow()
        )
        return ManageTariffView(viewModel: viewModel)
    }
    
    private func composeEditTariffView(_ tariff: Tariff) -> some View {
        let viewModel = ManageTariffViewModel(
            tariff: tariff,
            flow: flowFactory.getManageTariffFlow()
        )
        return ManageTariffView(viewModel: viewModel)
    }
    
    private func composePropertyObjectSettingsView(_ propObjId: PropertyObjectId) -> some View {
        let viewModel = PropertySettingsViewModel(
            objectId: propObjId,
            flow: flowFactory.getPropertyObjectSettingFlow()
        )
        return PropertySettingsView(viewModel: viewModel)
    }
    
    private func composeEditMeterView(_ meter: Meter) -> some View {
        let viewModel = EditMeterViewModel(
            meter: meter,
            flow: flowFactory.getManageMeterFlow()
        )
        return EditMeterView(viewModel: viewModel)
    }
    
    private func composeAddBillingMapView(_ billingMapData: BillingMapData) -> some View {
        let viewModel = BillingMapViewModel(
            billingMapData: billingMapData,
            flow: flowFactory.getManageBillingMapFlow()
        )
        return BillingMapView(viewModel: viewModel)
    }
    
    private func composeEditBillingMapView(_ billingMap: BillingMap, billingMapData: BillingMapData) -> some View {
        let viewModel = BillingMapViewModel(
            billingMap: billingMap,
            billingMapData: billingMapData,
            flow: flowFactory.getManageBillingMapFlow()
        )
        return BillingMapView(viewModel: viewModel)
    }
    
    func composeGenerateBillView(_ propObjId: PropertyObjectId) -> some View {
//        GenerateBillView()
        Text("Hi!")
    }
}

extension iOSAppViewFactory: ViewFactory {
    func view(for route: Route) -> any View {
        switch route {
        case .properlyObjectList:
            composePropertyObjectListView()
        case .propertyObjectHome(let uuid):
            composePropertyHomeView(uuid)
        case .editPropertyInfo(let obj):
            composeEditPropertyInfoView(obj)
        case .addMeter(let objId):
            composeAddMeterView(objId)
        case .meterValues(let meterId):
            composeMeterValuesView(meterId)
        case .addMeterValue(let meterId):
            composeAddMeterValueView(meterId)
        case .editMeterValue(let meterValue):
            composeEditMeterValueView(meterValue)
        case .addTariff(let objId):
            composeAddTariffView(objId)
        case .editTariff(let tariff):
            composeEditTariffView(tariff)
        case .propertyObjectSettings(let objId):
            composePropertyObjectSettingsView(objId)
        case .editMeter(let meter):
            composeEditMeterView(meter)
        case .addBillingMap(let objId):
            composeAddBillingMapView(objId)
        case .editBillingMap(let billingMap, let data):
            composeEditBillingMapView(billingMap, billingMapData: data)
        case .generateBill(let objId):
            composeGenerateBillView(objId)
            
        }
    }
}
