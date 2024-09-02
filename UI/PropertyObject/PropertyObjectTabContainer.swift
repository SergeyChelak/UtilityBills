//
//  PropertyObjectTabContainer.swift
//  UtilityBills
//
//  Created by Sergey on 29.08.2024.
//

import SwiftUI

struct PropertyObjectTabContainer: View {
    var body: some View {
        TabView {
            PropertyObjectInfoView()
                .tabItem {
                    Text("Home")
                }
            MeterListScreen()
                .tabItem {
                    Text("Meters")
                }
            TariffListScreen()
                .tabItem {
                    Text("Tariffs")
                }
            BillingScreen()
                .tabItem {
                    Text("Billing")
                }
        }
    }
}

#Preview {
    PropertyObjectTabContainer()
}
