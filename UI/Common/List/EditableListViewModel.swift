//
//  EditableListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

typealias ListActionRemove<T> = (T) throws -> Void
typealias ListActionCreate<T> = () throws -> T

class EditableListViewModel<T>: CommonListViewModel<T> {
    private let removeAction: ListActionRemove<T>?
    private let createAction: ListActionCreate<T>?
    
    init(
        loadAction: @escaping CommonListActionLoad<T>,
        selectAction: @escaping CommonListActionSelect<T> = { _ in },
        removeAction: ListActionRemove<T>? = nil,
        createAction: ListActionCreate<T>? = nil
    ) {
        self.removeAction = removeAction
        self.createAction = createAction
        super.init(
            actionLoad: loadAction,
            actionSelect: selectAction
        )
    }
    
    var isDeleteAllowed: Bool {
        removeAction != nil
    }
    
    var canCreateItems: Bool {
        createAction != nil
    }
                
    func onDelete(_ indexSet: IndexSet) {
        do {
            for index in indexSet {
                let item = items[index]
                try removeAction?(item)
            }
        } catch {
            print("Failed to remove items: \(error)")
            load()
        }
    }
    
    func onCreate() {
        do {
            _ = try createAction?()
            load()
        } catch {
            self.error = error
            print("Failed to create item: \(error)")
        }
    }
}
