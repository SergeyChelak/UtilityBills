//
//  StackNavigation+SwiftUI.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Foundation
import SwiftUI

extension StackNavigation {
    func push(_ view: AnyView) {
        push(ViewHolder(view))
    }

    func showSheet(_ view: AnyView) {
        showSheet(ViewHolder(view))
    }
    
    func setRoot(_ view: AnyView) {
        setRoot(ViewHolder(view))
    }
}
