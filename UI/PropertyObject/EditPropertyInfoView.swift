//
//  EditPropertyInfoView.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

struct EditPropertyInfoView: View {
    @StateObject
    var viewModel: EditPropertyInfoViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Object Properties")
                .padding(.top, 12)
            Spacer()
            TextField("", text: $viewModel.name)
                .inputStyle(caption: "Title")
                        
            TextField("", text: $viewModel.details)
                .inputStyle(caption: "Details")
            
            Spacer()
            CTAButton(caption: "Save", callback: viewModel.save)
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
    let vm = EditPropertyInfoViewModel(
        propertyObject: obj,
        delegate: nil
    )
    return EditPropertyInfoView(viewModel: vm)
}
