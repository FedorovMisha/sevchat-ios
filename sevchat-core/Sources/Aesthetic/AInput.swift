//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import SwiftUI

public struct AInput: View {

    public enum InputType {
        case text
        case secure
    }

    @Binding
    private var value: String

    @FocusState
    private var isFocused: Bool

    private let placeholder: String?
    private let icon: Image?
    private let right: AnyView?
    private let type: InputType
    private let isEditable: Bool
    private let error: String?
    private let axis: Axis

    public var body: some View {
        VStack {
            contentView
            errorView
        }
    }

    @ViewBuilder
    private var field: some View {
        switch type {
        case .text:
            TextField(
                "",
                text: $value,
                axis: axis
            )

        case .secure:
            SecureField(
                placeholder.map {
                    isFocused ? "" : $0
                } ?? "",
                text: $value
            )
        }
    }

    private var contentView: some View {
        HStack(spacing: .zero) {
            icon?
                .padding(.leading, 16.0)

            field
                .foregroundStyle(Color.Input.fText)
                .placeholder(when: value.isEmpty && !isFocused) {
                    Text(placeholder ?? "")
                        .foregroundStyle(Color.Input.emptyText)
                }
                .font(.inputValueFont)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.trailing, icon == nil ? 22.0 : 12.0)
                .padding(.leading, icon == nil ? 16.0 : 12.0)
                .padding(.vertical, 14.0)
                .focused($isFocused)
                .allowsHitTesting(isEditable)

            right?
                .padding(.trailing, 16.0)
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
        )
        .background {
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    isFocused ? Color.Input.focusedBorder : .Input.border
                )
        }
    }

    @ViewBuilder
    private var errorView: some View {
        if let error {
            Text(error)
                .foregroundStyle(.red)
        }
    }

    public init(
        value: Binding<String>,
        icon: Image? = nil,
        right: AnyView? = nil,
        placeholder: String? = nil,
        type: InputType = .text,
        error: String? = nil,
        axis: Axis = .horizontal,
        isEditable: Bool = true
    ) {
        self._value = value
        self.icon = icon
        self.placeholder = placeholder
        self.type = type
        self.right = right
        self.error = error
        self.axis = axis
        self.isEditable = isEditable
    }
}

extension View {

    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    AInput(value: .constant(""), icon: .mail, placeholder: "Text")
}
