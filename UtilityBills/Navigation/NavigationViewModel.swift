//
//  NavigationViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Foundation

class NavigationViewModel: ObservableObject, StackNavigation {
    private var viewBuffer: [ViewIdentifier: ViewHolder] = [:]
    @Published
    var navigationPath: [ViewIdentifier] = [] {
        didSet {
            cleanBuffer()
        }
    }
    @Published
    var sheetViewHolder: ViewHolder?
    @Published
    private(set) var rootViewHolder: ViewHolder
    
    init(rootView: ViewHolder = .default()) {
        self.rootViewHolder = rootView
    }
    
    private func cleanBuffer() {
        viewBuffer = viewBuffer.filter {
            navigationPath.contains($0.key)
        }
    }
    
    func viewHolder(for id: ViewIdentifier) -> ViewHolder {
        viewBuffer[id] ?? .empty()
    }
        
    func push(_ holder: ViewHolder) {
        hideSheet()
        let id = ViewIdentifier()
        viewBuffer[id] = holder
        navigationPath.append(id)
    }
    
    func pop() {
        hideSheet()
        _ = navigationPath.popLast()
    }
    
    func popToRoot() {
        hideSheet()
        navigationPath.removeAll()
    }
        
    func showSheet(_ holder: ViewHolder) {
        self.sheetViewHolder = holder
    }
    
    func hideSheet() {
        self.sheetViewHolder = nil
    }
    
    func setRoot(_ holder: ViewHolder) {
        self.navigationPath.removeAll()
        self.rootViewHolder = holder
    }
}
