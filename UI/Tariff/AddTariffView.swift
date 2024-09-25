//
//  AddTariffView.swift
//  UtilityBills
//
//  Created by Sergey on 25.09.2024.
//

import SwiftUI

struct AddTariffView: View {
    @StateObject
    var viewModel: AddTariffViewModel
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("Add new tariff")
                .font(.title)
                .frame(maxWidth: .infinity)
                .padding(.top, 12)
            
            TextField("", text: $viewModel.name)
                .inputStyle(caption: "Tariff name")
            
            TextField("", text: $viewModel.price)
                .keyboardType(.decimalPad)
                .inputStyle(caption: "Price")
            
            LazyVGrid(columns: adaptiveColumn, spacing: 10) {
                ForEach(viewModel.monthList.indices, id: \.self) { i in
                    Text(viewModel.monthList[i])
                        .foregroundStyle(viewModel.selected[i] ? .green : .primary)
                        .onTapGesture {
                            viewModel.toggle(i)
                        }
                        .padding(.vertical)
                }
            }
        
            Spacer()
            CTAButton(caption: "Add Tariff", callback: viewModel.save)
            .padding(.bottom, 12)
        }
        .padding(.horizontal)
        .errorAlert(for: $viewModel.error)
    }
}

#Preview {
    let vm = AddTariffViewModel(actionSave: { _ in })
    return AddTariffView(viewModel: vm)
}
