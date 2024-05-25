
import SwiftUI
import DaVinci

public struct AButton: View {

    public enum Style {
        case gradient
        case clear
    }

    let title: String
    let style: Style
    let action: () -> Void

    @Environment(\.isEnabled)
    private var isEnabled

    public var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.button)
                .padding(.vertical, 12.0)
                .foregroundStyle(textColor)
                .frame(maxWidth: .infinity)
                .background {
                    if isEnabled { 
                        background
                    } else {
                        Color.Button.buttonDisabled
                    }
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: 8.0)
                )
        }
    }

    @ViewBuilder
    private var background: some View {
        if style == .gradient {
            LinearGradient(
                colors: [Color.Button.buttonBg1, Color.Button.buttonBg2],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    private var textColor: Color {
        guard isEnabled && style == .clear else {
            return Color.white
        }
        return Color.tText
    }

    public init(
        title: String,
        style: Style = .gradient,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
}

#Preview {
    AButton(title: "Регестрация") {

    }
    .disabled(true)
}
