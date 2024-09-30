//
//  ControlButtonsView.swift
//  UtilityBills
//
//  Created by Sergey on 30.09.2024.
//

import SwiftUI

struct ControlButtonsView: View {
    let viewModel: ActionControllable
    
    var body: some View {
        VStack(spacing: 24) {
            ForEach(viewModel.actions, id: \.hashValue) { action in
                CTAButton(caption: action.name, actionKind: action.kind) {
                    viewModel.onAction(action)
                }
            }
        }
    }
}

#Preview {
    struct Model: ActionControllable {
        var actions: [ControlAction] {
            [.new, .update, .delete]
        }
        
        func onAction(_ action: ControlAction) {
            //
        }
    }
    return ControlButtonsView(viewModel: Model())
}
