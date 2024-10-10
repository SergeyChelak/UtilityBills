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
