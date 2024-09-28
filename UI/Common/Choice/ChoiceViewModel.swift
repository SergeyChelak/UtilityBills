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
        
    func onTap(_ index: Int) {
        isSelected[index].toggle()
    }
}
