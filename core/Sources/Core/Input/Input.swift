import SwiftUI

public struct InputContentView: View {
    
    public let placeholder: String
    
    @Binding
    public var value: String
    
    public let icon: Image?
    
    public let isSecure: Bool
    
    public var body: some View {
        HStack {
            if let icon {
               icon
                    .padding(.leading, 16.0)
            }
            
            contentView
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.trailing, 22.0)
                .padding(.leading, icon == nil ? 16.0 : 12.0)
        }
    }
    
    @ViewBuilder
    public var contentView: some View {
        if isSecure {
            SecureField(
                placeholder,
                text: $value
            )
        } else {
            TextField(
                placeholder,
                text: $value
            )
        }
    }
}

public struct Input: View {
    
    public let placeholder: String
    
    @Binding
    public var value: String
    
    public let icon: Image?
    
    public let isSecure: Bool
    
    @FocusState
    private var isFocused: Bool
    
    public var body: some View {
        InputContentView(
            placeholder: placeholder,
            value: $value,
            icon: icon,
            isSecure: isSecure
        )
        .focused($isFocused)
        .padding(.vertical, 14.0)
        .background(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(
                    Color(isFocused ? .tfBorderFocused : .tfBorder),
                    lineWidth: 1.0
                )
        )
        .onTapGesture {
            isFocused.toggle()
        }
    }
    
    public init(
        placeholder: String = "",
        value: Binding<String>,
        icon: Image? = nil,
        isSecure: Bool = false,
        isFocused: Bool = false
    ) {
        self.placeholder = placeholder
        self._value = value
        self.icon = icon
        self.isSecure = isSecure
        self.isFocused = isFocused
    }
}
