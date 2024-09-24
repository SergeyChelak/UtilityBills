//
//  CommonListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

typealias ListActionLoad<T> = () throws -> [T]
typealias ListActionSelect<T> = (T) -> ()
typealias ListActionRemove<T> = (T) throws -> Void
typealias ListActionCreate<T> = () throws -> T

final class CommonListViewModel<T>: ObservableObject {
    @Published
    private(set) var items: [T] = []
    @Published
    var error: Error?
    
    private let loadAction: ListActionLoad<T>
    private let selectAction: ListActionSelect<T>
    private let removeAction: ListActionRemove<T>?
    private let createAction: ListActionCreate<T>?
    
    init(
        loadAction: @escaping ListActionLoad<T>,
        selectAction: @escaping ListActionSelect<T> = { _ in },
        removeAction: ListActionRemove<T>? = nil,
        createAction: ListActionCreate<T>? = nil
    ) {
        self.loadAction = loadAction
        self.selectAction = selectAction
        self.removeAction = removeAction
        self.createAction = createAction
    }
    
    var isDeleteAllowed: Bool {
        removeAction != nil
    }
    
    var canCreateItems: Bool {
        createAction != nil
    }
        
    func load() {
        do {
            self.items = try loadAction()
        } catch {
            self.error = error
            print("Failed to load data: \(error)")
        }
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
    
    func onSelect(index: Int) {
        selectAction(items[index])
    }
}
