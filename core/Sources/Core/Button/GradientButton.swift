//
//  SwiftUIView.swift
//  
//
//  Created by Misha Fedorov on 23.04.2024.
//

import SwiftUI

public struct GradientButton: View {
    
    public let title: String
    
    public let isDisabled: Bool
    
    public let action: () -> Void
    
    public var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.stretchedButton)
                .foregroundStyle(Color(.btnText))
                .frame(maxWidth: .infinity, minHeight: 26.0)
                .padding(.vertical, 12.0)
                .background {
                    if isDisabled {
                        Color(.btnDisabled)
                    } else {
                        LinearGradient(
                            colors: [
                                Color(.btnGradientTop),
                                Color(.btnGradientBottom)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }
        .allowsHitTesting(!isDisabled)
    }
    
    public init(
        title: String,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isDisabled = isDisabled
        self.action = action
    }
}
