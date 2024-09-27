//
//  PropertySettingsView.swift
//  UtilityBillsTests
//
//  Created by Sergey on 27.09.2024.
//

import SwiftUI

struct PropertySettingsView: View {
    @StateObject
    var viewModel: PropertySettingsViewModel
    @State
    var isConfirmDeleteAlertVisible = false
    
    var body: some View {
        VStack {
            // Manage payment's settings
            Text("Content should be here")
            Spacer()
            CTAButton(
                caption: "Delete Object",
                fillColor: .red,
                callback: { isConfirmDeleteAlertVisible.toggle() }
            )
        }
        .padding(.horizontal)
        .navigationTitle("Settings")
        .errorAlert(for: $viewModel.error)
        .alert(isPresented: $isConfirmDeleteAlertVisible) {
            Alert(
                title: Text("Warning"),
                message: Text("Do you want to delete this object?"),
                primaryButton: .destructive(Text("Delete"), action: viewModel.deleteObject),
                secondaryButton: .default(Text("Cancel"))
            )
        }
    }
}

#Preview {
    let vm = PropertySettingsViewModel(
        objectId: UUID(),
        actionDelete: { }
    )
    return PropertySettingsView(viewModel: vm)
}
