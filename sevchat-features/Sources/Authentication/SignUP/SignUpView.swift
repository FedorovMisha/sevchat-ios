//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.

import DaVinci
import Aesthetic
import SwiftUI

public struct SignUpView: View {

    @StateObject
    private var viewModel = SignUpViewModel()

    @Environment(\.dismiss)
    private var dismiss

    public var body: some View {
        VStack {
            Image.chatIS
                .padding(.top, 14)
            Spacer()
            titleView
            contentView
            Spacer()
            footerView
        }
        .padding(.horizontal, 24.0)
    }

    private var titleView: some View {
        Text("Регистрация")
            .foregroundStyle(Color.tText)
            .font(.tFont)
            .padding(.bottom, 32.0)
    }

    private var contentView: some View {
        VStack(spacing: 15.0) {
            AInput(
                value: $viewModel.username,
                icon: .profile,
                placeholder: "Имя"
            )

            AInput(
                value: $viewModel.email,
                icon: .mail,
                placeholder: "Почта"
            )

            AInput(
                value: $viewModel.password,
                icon: .password,
                placeholder: "Пароль",
                type: .secure
            )

            AInput(
                value: $viewModel.confirmPassword,
                icon: .password,
                placeholder: "Повторите пароль",
                type: .secure
            )
        }
        .onChange(of: viewModel.signUpCompleted) { newValue in
            if newValue {
                dismiss()
            }
        }
    }

    private var footerView: some View {
        VStack(spacing: 14.0) {
            AButton(
                title: "Создать",
                action: viewModel.onSignInTap
            )
            .disabled(viewModel.isDisabledSignInButton)
        }
        .padding(.bottom, 25.0)
    }
}

#Preview {
    NavigationView {
        SignUpView()
    }
}
