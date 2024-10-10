//
//  AlertErrorViewModifier.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import SwiftUI

struct AlertErrorViewModifier: ViewModifier {
    @Binding
    var error: Error?
    let presenter: ErrorAlertPresenter
    
    init(error: Binding<Error?>, presenter: ErrorAlertPresenter) {
        self._error = error
        self.presenter = presenter
    }
    
    private var isErrorAlertVisible: Binding<Bool> {
        Binding(
            get: { error != nil },
            set: { if !$0 { error = nil } }
        )
    }
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: isErrorAlertVisible) {
                Alert(
                    title: Text(presenter.errorAlertTitle(error)),
                    message: Text(presenter.errorAlertMessage(error)),
                    dismissButton: .default(Text(presenter.dismissButtonTitle)))
            }
    }
}

extension View {
    func errorAlert(
        for error: Binding<Error?>,
        presenter: ErrorAlertPresenter = DefaultErrorAlertPresenter()
    ) -> some View {
        modifier(AlertErrorViewModifier(error: error, presenter: presenter))
    }
}
