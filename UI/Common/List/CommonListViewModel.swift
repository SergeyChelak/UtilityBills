//
//  CommonListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

typealias CommonListActionLoad<T> = () throws -> [T]
typealias CommonListActionSelect<T> = (T) -> ()

class CommonListViewModel<T>: ObservableObject {
    @Published
    var items: [T] = []
    @Published
    var error: Error?
    
    let actionLoad: CommonListActionLoad<T>
    let actionSelect: CommonListActionSelect<T>
    
    init(
        actionLoad: @escaping CommonListActionLoad<T>,
        actionSelect: @escaping CommonListActionSelect<T>
    ) {
        self.actionLoad = actionLoad
        self.actionSelect = actionSelect
    }
    
    var isEmpty: Bool {
        items.isEmpty
    }
    
    func load() {
        do {
            self.items = try actionLoad()
        } catch {
            self.error = error
            print("CommonListViewModel load failed: \(error)")
        }
    }
    
    func select(index: Int) {
        guard !items.isEmpty, (0..<items.count).contains(index) else {
            fatalError("Selected index \(index) is out of bounds 0..\(items.count)")
        }
        actionSelect(items[index])
    }
}
