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
    
    var body: some View {
        VStack {
            // Manage payment's settings
            Text("Content should be here")
            Spacer()
            CTAButton(
                caption: "Delete Object",
                fillColor: .red,
                callback: viewModel.deleteObject
            )
        }
        .padding(.horizontal)
        .navigationTitle("Settings")
    }
}

#Preview {
    let vm = PropertySettingsViewModel(
        objectId: UUID(),
        actionDelete: { }
    )
    return PropertySettingsView(viewModel: vm)
}
