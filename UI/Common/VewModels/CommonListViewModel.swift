//
//  CommonListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

typealias CommonListActionLoad<T> = () throws -> [T]
typealias CommonListActionSelect<T> = (T) -> ()

class CommonListViewModel<T>: ViewModel {
    @Published
    var items: [T] = []
    
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
            setError(error)
            print("CommonListViewModel load failed: \(error)")
        }
    }
    
    func select(index: Int) {
        guard !items.isEmpty, (0..<items.count).contains(index) else {
            self.error = NSError(domain: "UB.Index", code: 1)
            return
        }
        actionSelect(items[index])
    }
}
