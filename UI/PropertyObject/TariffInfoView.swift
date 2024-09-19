//
//  TariffInfoView.swift
//  UtilityBills
//
//  Created by Sergey on 20.09.2024.
//

import SwiftUI

struct TariffInfoView: View {
    let tariffs: [Tariff]
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    TariffInfoView(tariffs: [
        Tariff(id: UUID(),
               name: "Hot water",
               price: 356.43)
    ])
}
