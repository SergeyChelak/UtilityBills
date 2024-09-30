//
//  ChoiceViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 28.09.2024.
//

import Foundation

protocol ChoiceViewModel: ObservableObject {
    associatedtype T
    var items: [T] { get }
    
    var isSelected: [Bool] { get }
    
    func onTap(_ index: Int)
}

class SingleChoiceViewModel<T>: ChoiceViewModel {
    @Published
    private(set) var items: [T]
    @Published
    private(set) var isSelected: [Bool]
    
    init(items: [T]) {
        self.items = items
        self.isSelected = [Bool].init(repeating: false, count: items.count)
    }
    
    var isEmpty: Bool {
        items.isEmpty
    }
    
    var selected: T? {
        for i in 0..<items.count {
            if isSelected[i] {
                return items[i]
            }
        }
        return nil
    }
        
    func onTap(_ index: Int) {
        for i in 0..<isSelected.count {
            isSelected[i] = i == index
        }
    }
}

class MultiChoiceViewModel<T>: ChoiceViewModel {
    @Published
    private(set) var items: [T]
    @Published
    private(set) var isSelected: [Bool]
    
    init(items: [T], initialSelection: Bool = false) {
        self.items = items
        self.isSelected = [Bool].init(
            repeating: initialSelection,
            count: items.count
        )
    }
    
    init(items: [T], selection: (Int) -> Bool) {
        self.items = items
        self.isSelected = [Bool].init(
            repeating: false,
            count: items.count
        )
        for i in 0..<items.count {
            self.isSelected[i] = selection(i)
        }
    }

    var isEmpty: Bool {
        items.isEmpty
    }
    
    var selected: [T] {
        var result: [T] = []
        for i in 0..<isSelected.count {
            if !isSelected[i] {
                continue
            }
            result.append(items[i])
        }
        return result
    }
        
    func onTap(_ index: Int) {
        isSelected[index].toggle()
    }
}
