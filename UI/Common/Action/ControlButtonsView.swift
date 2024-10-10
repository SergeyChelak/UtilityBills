//
//  ControlButtonsView.swift
//  UtilityBills
//
//  Created by Sergey on 30.09.2024.
//

import SwiftUI

struct ControlButtonsView: View {
    let viewModel: ActionControllable
    let presenter: ControlButtonsPresenter
    
    init(
        viewModel: ActionControllable,
        presenter: ControlButtonsPresenter = DefaultControlButtonsPresenter()
    ) {
        self.viewModel = viewModel
        self.presenter = presenter
    }
    
    var body: some View {
        VStack(spacing: 24) {
            ForEach(viewModel.actions, id: \.hashValue) { action in
                CTAButton(
                    caption: presenter.actionName(action),
                    actionKind: action.kind
                ) {
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
