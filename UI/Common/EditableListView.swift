//
//  EditableListView.swift
//  UtilityBills
//
//  Created by Sergey on 07.09.2024.
//

import SwiftUI

typealias EditableListLoader<T> = () throws -> [T]
typealias EditableListRemover<T> = (T) throws -> Void
typealias EditableListCreator<T> = () throws -> T

final class EditableListStore<T>: ObservableObject {
    @Published
    private(set) var items: [T] = []
    
    private let loader: EditableListLoader<T>
    private let remover: EditableListRemover<T>?
    private let creator: EditableListCreator<T>?
    
    init(
        loader: @escaping EditableListLoader<T>,
        remover: EditableListRemover<T>? = nil,
        creator: EditableListCreator<T>? = nil
    ) {
        self.loader = loader
        self.remover = remover
        self.creator = creator
    }
    
    var isDeleteAllowed: Bool {
        remover != nil
    }
    
    var canCreateItems: Bool {
        creator != nil
    }
        
    func load() {
        do {
            self.items = try loader()
        } catch {
            fatalError("Failed to load data")
        }
    }
    
    func onDelete(_ indexSet: IndexSet) {
        do {
            for index in indexSet {
                let item = items[index]
                try remover?(item)
            }
        } catch {
            print("Failed to remove items, reload")
            load()
        }
    }
    
    func onCreate() {
        do {
            _ = try creator?()
            load()
        } catch {
            fatalError("Failed to create item")
        }
    }
}


struct EditableListView<ElementType, StoreType: EditableListStore<ElementType>, ViewType: View>: View {
    let title: String
    @ObservedObject var store: StoreType
    let factory: (ElementType) -> ViewType
    let selection: (ElementType) -> Void
    
    var body: some View {
        List {
            ForEach(store.items.indices, id: \.self) { i in
                factory(store.items[i])
                    .onTapGesture {
                        selection(store.items[i])
                    }
            }
            .onDelete(perform: store.onDelete(_:))
            .deleteDisabled(!store.isDeleteAllowed)
        }
        .navigationTitle(title)
        .toolbar {
            if store.canCreateItems {
                ToolbarItem {
                    Button("Add") {
                        store.onCreate()
                    }
                }
            }
        }
        .task {
            store.load()
        }
    }
}

//#Preview {
//    let store = CommonListStore<Int>()
//    let factory = { (val: Int) -> View in
//        EmptyView
//    }
//    let selection = { (val: Int) -> Void in
//        //
//    }
//    let view =  CommonListView(
//        store: store,
//        factory: factory,
//        selection: selection
//    )
//    return AnyView(view)
//}
