//
//  UBImage.swift
//  UtilityBills
//
//  Created by Sergey on 07.09.2024.
//

import SwiftUI

struct ImageDescriptor {
    enum ImageType {
        case system, bundle
    }
    let type: ImageType
    let name: String
    
    static func system(_ name: String) -> Self {
        ImageDescriptor(type: .system, name: name)
    }
    
    static func bundle(_ name: String) -> Self {
        ImageDescriptor(type: .bundle, name: name)
    }
}

struct UBImage: View {
    let descriptor: ImageDescriptor
    
    var body: some View {
        switch descriptor.type {
        case .system:
            Image(systemName: descriptor.name)
        case .bundle:
            Image(descriptor.name)
        }
    }
}
