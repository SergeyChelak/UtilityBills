//
//  GenerateBillView.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

import SwiftUI

struct GenerateBillView: View {
    var body: some View {
        VStack {
            Text("Generate bill")
            Spacer()
            CTAButton(
                caption: "Accept",
                callback: { }
            )
        }
        .navigationTitle("New Bill")
    }
}

#Preview {
    GenerateBillView()
}
