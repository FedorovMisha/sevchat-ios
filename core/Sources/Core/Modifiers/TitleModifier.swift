//
//  File.swift
//  
//
//  Created by Misha Fedorov on 23.04.2024.
//

import SwiftUI

extension Font {
    
    public static var h1: Font {
        .system(size: 32, weight: .bold)
    }
    
    public static var smButton: Font {
        .system(size: 16.0, weight: .bold)
    }
    
    public static var stretchedButton: Font {
        .system(size: 18.0, weight: .bold)
    }
    
    public static var textField: Font {
        .system(size: 14, weight: .regular, design: .default)
    }
}

#Preview {
    Text("Добро пожаловать")
        .font(.h1)
}
