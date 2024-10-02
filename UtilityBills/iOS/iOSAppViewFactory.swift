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
    
    // Temporary variables for migration purposes
    var storage: LocalStorage {
        appFlow.storage
    }
    
    var storageWatcher: UpdatePublisher {
        appFlow.updatePublisher
    }
    
    var router: Router {
        appFlow.router
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
        let vm = AddMeterViewModel(propertyObjectId: propObjId) { meter, initialValue in
            try storage.newMeter(
                propertyObjectId: propObjId,
                meter: meter,
                initialValue: initialValue)
            router.hideOverlay()
        }
        return AddMeterView(viewModel: vm)
    }
    
    private func composeMeterValuesView(_ meterId: MeterId) -> some View {
        let viewModel = MeterValuesListViewModel(
            actionLoad: { try storage.meterValues(meterId) },
            actionNewValue: {
                router.showOverlay(.addMeterValue(meterId))
            },
            actionSelect: {
                router.showOverlay(.editMeterValue($0))
            },
            updatePublisher: storageWatcher.publisher
        )
        return MeterValuesListView(viewModel: viewModel)
    }
    
    private func composeAddMeterValueView(_ meterId: MeterId) -> some View {
        let viewModel = MeterValueViewModel(
            date: Date(),
            value: 0,
            actionAdd: {
                try storage.insertMeterValue(meterId, value: $0)
                router.hideOverlay()
            }
        )
        return MeterValueView(viewModel: viewModel)
    }
    
    private func composeEditMeterValueView(_ meterValue: MeterValue) -> some View {
        let viewModel = MeterValueViewModel(
            meterValue: meterValue,
            actionUpdate: {
                try storage.updateMeterValue($0)
                router.hideOverlay()
            },
            actionDelete: {
                try storage.deleteMeterValue($0)
                router.hideOverlay()
            }
        )
        return MeterValueView(viewModel: viewModel)
    }
    
    private func composeAddTariffView(_ propObjId: PropertyObjectId) -> some View {
        let viewModel = ManageTariffViewModel(
            actionSave: {
                try storage.newTariff(propertyId: propObjId, tariff: $0)
                router.hideOverlay()
            }
        )
        return ManageTariffView(viewModel: viewModel)
    }
    
    private func composeEditTariffView(_ tariff: Tariff) -> some View {
        let viewModel = ManageTariffViewModel(
            tariff: tariff,
            actionUpdate: {
                try storage.updateTariff(tariff: $0)
                router.hideOverlay()
            },
            actionDelete: {
                try storage.deleteTariff(tariffId: $0)
                router.hideOverlay()
            }
        )
        return ManageTariffView(viewModel: viewModel)
    }
    
    private func composePropertyObjectSettingsView(_ propObjId: PropertyObjectId) -> some View {
        let viewModel = PropertySettingsViewModel(
            objectId: propObjId,
            actionLoad: {
                let meters = try storage.allMeters(propObjId)
                let tariffs = try storage.allTariffs(propObjId)
                let billingMaps = try storage.allBillingMaps(propObjId)
                return PropertySettingsData(
                    meters: meters,
                    tariffs: tariffs,
                    billingMaps: billingMaps
                )
            },
            actionMeterHeaderSectionTap: { router.showOverlay(.addMeter($0)) },
            actionMeterSelectionTap: { router.showOverlay(.editMeter($0)) },
            actionAddTariff: { router.showOverlay(.addTariff($0)) },
            actionEditTariff: { router.showOverlay(.editTariff($0)) },
            actionAddBillingMap: { router.showOverlay(.addBillingMap($0)) },
            actionEditBillingMap: { router.showOverlay(.editBillingMap($0, $1)) },
            actionDelete: {
                try storage.deleteProperty(propObjId)
                router.popToRoot()
            },
            updatePublisher: storageWatcher.publisher
        )
        return PropertySettingsView(viewModel: viewModel)
    }
    
    private func composeEditMeterView(_ meter: Meter) -> some View {
        let viewModel = EditMeterViewModel(
            meter: meter,
            actionUpdateMeter: {
                try storage.updateMeter($0)
                router.hideOverlay()
            },
            actionDeleteMeter: {
                try storage.deleteMeter(meter.id)
                router.hideOverlay()
            }
        )
        return EditMeterView(viewModel: viewModel)
    }
    
    private func composeAddBillingMapView(_ billingMapData: BillingMapData) -> some View {
        let viewModel = BillingMapViewModel(
            billingMapData: billingMapData,
            actionSave: {
                try storage.newBillingMap(billingMapData.propertyObjectId, value: $0)
                router.hideOverlay()
            })
        return BillingMapView(viewModel: viewModel)
    }
    
    private func composeEditBillingMapView(_ billingMap: BillingMap, billingMapData: BillingMapData) -> some View {
        let viewModel = BillingMapViewModel(
            billingMap: billingMap,
            billingMapData: billingMapData,
            actionUpdate: {
                try storage.updateBillingMap($0)
                router.hideOverlay()
            },
            actionDelete: {
                try storage.deleteBillingMap($0)
                router.hideOverlay()
            }
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
