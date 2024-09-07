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
        VStack {
            List {
                ForEach(store.meters.indices, id: \.self) { i in
                    let meter = store.meters[i]
                    Text(meter.name)
                }
            }
            Spacer()
        }
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
    
    struct Wrapper<T: View>: View {
        let view: T
        var body: some View {
            NavigationStack {
                TabView {
                    view
                        .tabItem { Text("Test") }
                }
            }
        }
    }
    
    let view = MeterListView(store: store)
    
    return Wrapper(view: view)
}
