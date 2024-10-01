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
    let storage: LocalStorage
    let storageWatcher: StorageWatcher
    let router: Router
    
    init(navigationController: Router) {
        self.router = navigationController
        
        // TODO: inject dependency as protocol
        let storage = LocalStorage.instance()
        let storageWatcher = StorageWatcher(storage: storage)
        
        self.storage = storage
        self.storageWatcher = storageWatcher
    }
    
    private func composePropertyObjectListView() -> some View {
        let viewModel = PropertyListViewModel(
            actionLoad: storage.allProperties,
            actionSelect: { router.push(.propertyObjectHome($0.id)) },
            actionCreate: storage.createProperty
        )
        return PropertyListView(viewModel: viewModel)
    }
    
    private func composePropertyHomeView(_ propObjId: PropertyObjectId) -> some View {
        let viewModel = PropertyObjectViewModel(
            propObjId,
            actionLoad: {
                let propObj = try storage.fetchProperty(propObjId)
                let meters = try storage.allMeters(for: propObjId)
                return PropertyObjectData(
                    propObj: propObj,
                    meters: meters
                )
            },
            actionInfoSectionTap: { router.showOverlay(.editPropertyInfo($0)) },
            actionMeterSelectionTap: { router.push(.meterValues($0)) },
            actionSettings: { router.push(.propertyObjectSettings(propObjId)) },
            updatePublisher: storageWatcher.publisher
        )
        return PropertyObjectView(viewModel: viewModel)
    }
    
    private func composeEditPropertyInfoView(_ obj: PropertyObject) -> some View {
        let viewModel = EditPropertyInfoViewModel(
            propertyObject: obj,
            actionUpdate: {
                try storage.updateProperty($0)
                router.hideOverlay()
            }
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
                let meters = try storage.allMeters(for: propObjId)
                let tariffs = try storage.allTariffs(for: propObjId)
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
    
    private func composeAddBillingMapView(_ propObjId: PropertyObjectId) -> some View {
        let viewModel = BillingMapViewModel(
            actionLoad: {
                let meters = try storage.allMeters(for: propObjId)
                let tariffs = try storage.allTariffs(for: propObjId)
                return BillingMapData(
                    tariffs: tariffs,
                    meters: meters
                )
            },
            actionSave: {
                try storage.newBillingMap(propObjId, value: $0)
                router.hideOverlay()
            })
        return BillingMapView(viewModel: viewModel)
    }
    
    private func composeEditBillingMapView(_ propObjId: PropertyObjectId, billingMap: BillingMap) -> some View {
        let viewModel = BillingMapViewModel(
            billingMap: billingMap,
            // TODO: fix copy-paste!!!
            actionLoad: {
                let meters = try storage.allMeters(for: propObjId)
                let tariffs = try storage.allTariffs(for: propObjId)
                return BillingMapData(
                    tariffs: tariffs,
                    meters: meters
                )
            },
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
        case .editBillingMap(let objId, let billingMap):
            composeEditBillingMapView(objId, billingMap: billingMap)
        }
    }
}
