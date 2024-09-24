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
    
    init(error: Binding<Error?>) {
        self._error = error
    }
    
    private var isErrorAlertVisible: Binding<Bool> {
        Binding(
            get: { error != nil },
            set: { if !$0 { error = nil } }
        )
    }
    
    private var message: String {
        error?.localizedDescription ??  "Something went wrong"
    }
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: isErrorAlertVisible) {
                Alert(
                    title: Text("Error"),
                    message: Text(message),
                    dismissButton: .default(Text("Dismiss")))
            }
    }
}

extension View {
    func errorAlert(for error: Binding<Error?>) -> some View {
        modifier(AlertErrorViewModifier(error: error))
    }
}
