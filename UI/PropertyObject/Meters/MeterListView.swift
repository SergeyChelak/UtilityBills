//
//  MeterListView.swift
//  UtilityBills
//
//  Created by Sergey on 29.08.2024.
//

import SwiftUI

struct MeterListView: View {
    @ObservedObject var store: MeterListStore
    
    var body: some View {
        Text("MeterListScreen")
            .task {
                store.load()
            }
    }
}

#Preview {
    let store = MeterListStore(
        propertyId: UUID(),
        dataSource: LocalStorage.previewInstance()
    )
    return MeterListView(store: store)
}
