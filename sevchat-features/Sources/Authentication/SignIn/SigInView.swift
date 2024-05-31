//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import DaVinci
import Aesthetic
import APIModelKit
import NetSpark
import SwiftUI

public struct SignInView: View {

    @StateObject
    private var viewModel = SignInViewModel()

    @EnvironmentObject
    private var navigation: NavigationObject

    public var body: some View {
        VStack {
            Spacer()
            helloView
            contentView
            Spacer()
            footerView
        }
        .padding(.horizontal, 24.0)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image.chatIS
            }
        }
    }

    private var helloView: some View {
        Text("Добро пожаловать")
            .foregroundStyle(Color.tText)
            .font(.tFont)
            .padding(.bottom, 42.0)
    }

    private var contentView: some View {
        VStack(spacing: 15.0) {
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
        }
    }

    private var footerView: some View {
        VStack(spacing: 14.0) {
            AButton(
                title: "Войти",
                action: viewModel.onSignInTap
            )
            .disabled(viewModel.isDisabledSignInButton)

            AButton(
                title: "Регистрация",
                style: .clear
            ) {
                navigation.sheet(.signUp)
            }
        }
        .padding(.bottom, 25.0)
    }
}

#Preview {
    NavigationView {
        SignInView()
    }
}
