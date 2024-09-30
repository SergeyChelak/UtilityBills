//
//  ControlAction.swift
//  UtilityBills
//
//  Created by Sergey on 30.09.2024.
//

import Foundation

enum ControlAction: Hashable {
    case new
    case update
    case delete
    
    // TODO: move to presentation layer
    var name: String {
        switch self {
        case .new:
            "Add"
        case .update:
            "Update"
        case .delete:
            "Delete"
        }
    }
    
    var kind: ActionKind {
        switch self {
        case .new:
                .normal
        case .update:
                .normal
        case .delete:
                .destructive
        }
    }
}

protocol ActionControllable {
    var actions: [ControlAction] { get }
    
    func onAction(_ action: ControlAction)
}
