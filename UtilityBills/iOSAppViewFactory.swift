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
//     TODO: make dependency via protocol
    let storage = {
        let ls = LocalStorage.instance()
        return PublishedLocalStorage(storage: ls)
    }()
    let router: Router
    
    init(navigationController: Router) {
        self.router = navigationController
    }
    
    private func composePropertyObjectListView() -> some View {
        let viewModel = PropertyListViewModel(
            actionLoad: storage.allProperties,
            actionSelect: { router.push(.propertyObjectHome($0.id)) },
            actionCreate: storage.createProperty,
            actionRemove: storage.deleteProperty
        )
        return PropertyListView(viewModel: viewModel)
    }
    
    private func composePropertyHomeView(_ uuid: PropertyObjectId) -> some View {
        // TODO: looks bad, refactor this
        let viewModel = PropertyObjectViewModel(
            uuid,
            dataSource: storage,
            updatePublisher: storage.publisher,
            infoSectionCallback: { router.showOverlay(.editPropertyInfo($0)) },
            meterHeaderSectionCallback: { router.showOverlay(.addMeter($0)) },
            meterSelectionCallback: { router.push(.meterValues($0)) }
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
        let vm = AddMeterViewModel(propertyObjectId: propObjId) { name, capacity, inspectionDate, initialValue in
            _ = try storage.newMeter(
                propertyObjectId: propObjId,
                name: name,
                capacity: capacity,
                inspectionDate: inspectionDate,
                initialValue: initialValue)
            router.hideOverlay()
        }
        return AddMeterView(viewModel: vm)
    }
    
    private func composeMeterValuesView(_ meterId: MeterId) -> some View {
        let viewModel = EditableListViewModel<MeterValue>(
            loadAction: { try storage.meterValues(meterId) }
//            createAction: { router.showOverlay(.addMeterValue(meterId)) }
        )
        return EditableListView(
            title: "Values",
            viewModel: viewModel,
            factory: {
                CaptionValueCell(
                    caption: $0.date.formatted(),
                    value: $0.value.formatted()
                )
            }
        )
    }
    
    private func composeAddMeterValueView(_ meterId: MeterId) -> some View {
        Text("AddMeterValueView")
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
        }
    }
}
