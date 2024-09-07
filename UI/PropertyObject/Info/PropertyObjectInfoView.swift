//
//  PropertyObjectInfoView.swift
//  UtilityBills
//
//  Created by Sergey on 29.08.2024.
//

import SwiftUI

struct PropertyObjectInfoView: View {
    @ObservedObject var store: PropertyObjectInfoStore
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                PropertyObjectDetails(info: $store.info)
                Spacer()
            }
        }
        .task {
            store.load()
        }
    }
}

struct PropertyObjectDetails: View {
    @Binding var info: PropertyObjectInfo?
    
    var body: some View {
        if let info {
            VStack {
                HStack(spacing: 8) {
                    Text("Object:")
                    Text(info.name)                    
                }
                HStack(spacing: 8) {
                    Text("Details:")
                    Text(info.details)
                }
            }
        } else {
            Text("Object not found")
        }
    }
}

#Preview {
    let store = PropertyObjectInfoStore(
        UUID(),
        storage: LocalStorage.previewInstance()
    )
    return PropertyObjectInfoView(store: store)
}
