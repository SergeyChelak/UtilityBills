//
//  UIUtils.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation
import SwiftUI

func confirmationAlert(
    presenter: ConfirmationAlertPresenter,
    action: @escaping () -> Void
) -> Alert {
    Alert(
        title: Text(presenter.title),
        message: Text(presenter.message),
        primaryButton: .destructive(Text(presenter.confirmButtonTitle), action: action),
        secondaryButton: .default(Text(presenter.cancelButtonTitle))
    )
}
