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
    private let appFlow: iOSAppFlow
    
    init(appFlow: iOSAppFlow) {
        self.appFlow = appFlow
    }
    
    private func composePropertyObjectListView() -> some View {
        let viewModel = PropertyListViewModel(delegate: appFlow)
        return PropertyListView(viewModel: viewModel)
    }
    
    private func composePropertyHomeView(_ propObjId: PropertyObjectId) -> some View {
        let viewModel = PropertyObjectViewModel(
            propObjId,
            delegate: appFlow
        )
        return PropertyObjectView(viewModel: viewModel)
    }
    
    private func composeEditPropertyInfoView(_ obj: PropertyObject) -> some View {
        let viewModel = EditPropertyInfoViewModel(
            propertyObject: obj,
            delegate: appFlow
        )
        return EditPropertyInfoView(viewModel: viewModel)
    }
    
    private func composeAddMeterView(_ propObjId: PropertyObjectId) -> some View {
        let vm = AddMeterViewModel(
            propertyObjectId: propObjId,
            delegate: appFlow
        )
        return AddMeterView(viewModel: vm)
    }
    
    private func composeMeterValuesView(_ meterId: MeterId) -> some View {
        let viewModel = MeterValuesListViewModel(
            meterId: meterId,
            delegate: appFlow
        )
        return MeterValuesListView(viewModel: viewModel)
    }
    
    private func composeAddMeterValueView(_ meterId: MeterId) -> some View {
        let viewModel = MeterValueViewModel(
            meterId: meterId,
            date: Date(),
            value: 0,
            delegate: appFlow
        )
        return MeterValueView(viewModel: viewModel)
    }
    
    private func composeEditMeterValueView(_ meterValue: MeterValue) -> some View {
        let viewModel = MeterValueViewModel(
            meterValue: meterValue,
            delegate: appFlow
        )
        return MeterValueView(viewModel: viewModel)
    }
    
    private func composeAddTariffView(_ propObjId: PropertyObjectId) -> some View {
        let viewModel = ManageTariffViewModel(
            propertyObjectId: propObjId,
            delegate: appFlow
        )
        return ManageTariffView(viewModel: viewModel)
    }
    
    private func composeEditTariffView(_ tariff: Tariff) -> some View {
        let viewModel = ManageTariffViewModel(
            tariff: tariff,
            delegate: appFlow
        )
        return ManageTariffView(viewModel: viewModel)
    }
    
    private func composePropertyObjectSettingsView(_ propObjId: PropertyObjectId) -> some View {
        let viewModel = PropertySettingsViewModel(
            objectId: propObjId,
            delegate: appFlow
        )
        return PropertySettingsView(viewModel: viewModel)
    }
    
    private func composeEditMeterView(_ meter: Meter) -> some View {
        let viewModel = EditMeterViewModel(
            meter: meter,
            delegate: appFlow
        )
        return EditMeterView(viewModel: viewModel)
    }
    
    private func composeAddBillingMapView(_ billingMapData: BillingMapData) -> some View {
        let viewModel = BillingMapViewModel(
            billingMapData: billingMapData,
            delegate: appFlow
        )
        return BillingMapView(viewModel: viewModel)
    }
    
    private func composeEditBillingMapView(_ billingMap: BillingMap, billingMapData: BillingMapData) -> some View {
        let viewModel = BillingMapViewModel(
            billingMap: billingMap,
            billingMapData: billingMapData,
            delegate: appFlow
        )
        return BillingMapView(viewModel: viewModel)
    }
    
    func composeGenerateBillView(_ propObjId: PropertyObjectId) -> some View {
        GenerateBillView()
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
