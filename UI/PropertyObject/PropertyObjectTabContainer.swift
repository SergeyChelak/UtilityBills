//
//  PropertyObjectTabContainer.swift
//  UtilityBills
//
//  Created by Sergey on 29.08.2024.
//

import SwiftUI

struct TabDescriptor {
    let view: AnyView
    let text: String?
    let imageDescriptor: ImageDescriptor?
    
    init<T: View>(view: T, text: String? = nil, imageDescriptor: ImageDescriptor? = nil) {
        self.view = AnyView(view)
        self.text = text
        self.imageDescriptor = imageDescriptor
    }
}

struct PropertyObjectTabContainer: View {
    let tabs: [TabDescriptor]
    
    var body: some View {
        TabView {
            ForEach(tabs.indices, id: \.self) { index in
                let tab = tabs[index]
                tab.view
                    .tabItem {
                        if let descriptor = tab.imageDescriptor {
                            UBImage(descriptor: descriptor)
                        }
                        if let text = tab.text {
                            Text(text)
                        }
                    }
            }
        }
    }
}

#Preview {
    let tabs: [TabDescriptor] = []
    return PropertyObjectTabContainer(tabs: tabs)
}
