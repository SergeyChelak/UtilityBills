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
    
    private func composePropertyHomeView(_ objectId: PropertyObjectId) -> some View {
        let viewModel = PropertyObjectViewModel(
            objectId,
            actionLoad: {
                let propObj = try storage.fetchProperty(objectId)
                return PropertyObjectData(
                    propObj: propObj
                )
            },
            actionInfoSectionTap: { router.showOverlay(.editPropertyInfo($0)) },
            actionSettings: { router.push(.propertyObjectSettings(objectId)) },
            updatePublisher: storageWatcher.publisher
        )
        return PropertyObjectView(viewModel: viewModel)
    }
    
    private func composeEditPropertyInfoView(_ obj: PropertyObject) -> some View {
        EditPropertyInfoView(
            propertyObject: obj,
            callback: { try storage.updateProperty($0) }
        )
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
            actionSelect: { _ in },
            actionDeleteMeter: {
                try storage.deleteMeter(meterId)
                router.pop()
            },
            updatePublisher: storageWatcher.publisher
        )
        return MeterValuesListView(viewModel: viewModel)
    }
    
    private func composeAddMeterValueView(_ meterId: MeterId) -> some View {
        let viewModel = MeterNewValueViewModel(
            date: Date(),
            value: 0,
            actionSave: {
                try storage.insertMeterValue(meterId, value: $0)
                router.hideOverlay()
            }
        )
        return MeterNewValueView(viewModel: viewModel)
    }
    
    private func composeAddTariffView(_ propertyObjectId: PropertyObjectId) -> some View {
        let viewModel = AddTariffViewModel(
            actionSave: {
                try storage.newTariff(propertyId: propertyObjectId, tariff: $0)
                router.hideOverlay()
            }
        )
        return AddTariffView(viewModel: viewModel)
    }
    
    private func composePropertyObjectSettingsView(_ propertyObjectId: PropertyObjectId) -> some View {
        let viewModel = PropertySettingsViewModel(
            objectId: propertyObjectId,
            actionLoad: {
                let meters = try storage.allMeters(for: propertyObjectId)
                let tariffs = try storage.allTariffs(for: propertyObjectId)
                let billingMaps = try storage.allBillingMaps(propertyObjectId)
                return PropertySettingsData(
                    meters: meters,
                    tariffs: tariffs,
                    billingMaps: billingMaps
                )
            },
            actionMeterHeaderSectionTap: { router.showOverlay(.addMeter($0)) },
            actionMeterSelectionTap: { router.push(.meterValues($0)) },
            actionAddTariff: { router.showOverlay(.addTariff($0)) },
            actionDelete: {
                try storage.deleteProperty(propertyObjectId)
                router.popToRoot()
            },
            updatePublisher: storageWatcher.publisher
        )
        return PropertySettingsView(viewModel: viewModel)
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
        case .addTariff(let objId):
            composeAddTariffView(objId)
        case .propertyObjectSettings(let objId):
            composePropertyObjectSettingsView(objId)
        }
    }
}
