//
//  ObjectListView.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import SwiftUI

struct ObjectListView: View {
    @ObservedObject var store: ObjectListStore
    
    private var screenTitle: String {
        "My Objects"
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(store.items.indices, id: \.self) { index in
                    let item = store.items[index]
                    ObjectListCell(item: item)
                }
            }
            Spacer()
        }
        .navigationTitle(screenTitle)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Add") {
                    store.addObject()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    //
                }
            }
        }
        .task {
            store.load()
        }
    }
}

#Preview {
    // TODO: replace to interface to avoid coupling with a local storage class
    let store = ObjectListStore(dataSource: LocalStorage.previewInstance())
    let view = ObjectListView(store: store)
    
    struct ObjectListViewWrap: View {
        let contentView: ObjectListView
        
        var body: some View {
            NavigationStack {
                contentView
            }
        }
    }
    
    return ObjectListViewWrap(contentView: view)
}
