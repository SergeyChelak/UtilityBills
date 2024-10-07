//
//  ManagePropertyObjectView.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

struct ManagePropertyObjectView: View {
    @StateObject
    var viewModel: ManagePropertyObjectViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Object Properties")
                .popoverTitle()
                
            Spacer()
            TextField("", text: $viewModel.name)
                .inputStyle(caption: "Title")
                        
            TextField("", text: $viewModel.details)
                .inputStyle(caption: "Details")
            
            Spacer()
            ControlButtonsView(viewModel: viewModel)
                .padding(.bottom, 12)
        }
        .padding(.horizontal)
        .errorAlert(for: $viewModel.error)
    }
}

#Preview {
    let obj = PropertyObject(
        id: UUID(),
        name: "Villa",
        details: "Unknown Road, 42"
    )
    let vm = ManagePropertyObjectViewModel(
        propertyObject: obj,
        updateFlow: nil
    )
    return ManagePropertyObjectView(viewModel: vm)
}
