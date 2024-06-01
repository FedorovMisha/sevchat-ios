//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import Aesthetic
import DaVinci
import SwiftUI

public struct GenericProfileView<BottomContent: View>: View {

    let userName: String
    let status: String
    

    public var gradient = Gradient(
        stops: [
            .init(color: .ProfileGradient.c1, location: 0.39),
            .init(color: .ProfileGradient.c2, location: 0.98)
        ]
    )

    public var content: () -> BottomContent

    public var body: some View {
        VStack {
            LinearGradient(
                gradient: gradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(edges: .top)
            .overlay(alignment: .center) {
                userInfo
            }
            .frame(maxHeight: .infinity)

            content()
                .padding(.horizontal, 16)
                .padding(.bottom, 29)
                .padding(.top, -26)
        }
    }

    private var userInfo: some View {
        VStack {
            Text(userName)
                .font(.system(size: 50, weight: .regular))
            Text(status)
                .font(.system(size: 18, weight: .medium))
        }
        .foregroundStyle(Color.wText)
        .frame(height: 126)
    }
}

public func LogoutButton(_ action: @escaping () -> Void) -> some View {
    Button {
        action()
    } label: {
        Image.solarLogoutBroken
            .padding(10)
            .background(
                Circle()
                    .fill(.white.opacity(0.4))
                    .shadow(color: .black.opacity(0.05), radius: 50, y: 26)
            )
    }
    .buttonStyle(.plain)
}

#Preview {
    NavigationStack {
        GenericProfileView(userName: "Nicolas", status: "В сети") {
            VStack(spacing: 8) {
                AInput(value: .constant("Person"), icon: .profile)
                AInput(value: .constant("example@example.com"), icon: .mail)

                AButton(title: "Изменить") {

                }
                .shadow(color: .black.opacity(0.05), radius: 50, y: 26)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                LogoutButton {

                }
            }
        }
    }
}
