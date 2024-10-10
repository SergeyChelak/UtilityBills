//
//  UBImage.swift
//  UtilityBills
//
//  Created by Sergey on 07.09.2024.
//

import SwiftUI

struct ImageHolder {
    enum ImageType {
        case system, bundle
    }
    let type: ImageType
    let name: String
    
    static func system(_ name: String) -> Self {
        ImageHolder(type: .system, name: name)
    }
    
    static func bundle(_ name: String) -> Self {
        ImageHolder(type: .bundle, name: name)
    }
}

struct UBImage: View {
    let holder: ImageHolder
    
    var body: some View {
        switch holder.type {
        case .system:
            Image(systemName: holder.name)
        case .bundle:
            Image(holder.name)
        }
    }
}
