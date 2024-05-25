//
//  SwiftUIView.swift
//  
//
//  Created by Misha Fedorov on 23.04.2024.
//

import Core
import SwiftUI

struct SignInButtonsStack: View {
    
    @ObservedObject
    var viewModel: SignInViewModel
    
    @EnvironmentObject
    private var state: AuthNavigationState
    
    var body: some View {
        VStack(spacing: 14.0) {
            
            GradientButton(
                title: "Войти",
                isDisabled: !viewModel.canSignIn
            ) {
                viewModel.onSignInTap()
            }
            
            Button {
                state.showSignUp = true
            } label: {
                Text("Регистрация")
                    .font(.smButton)
                    .foregroundStyle(Color(.h1))
                    .frame(height: 26.0)
            }
        }
        .padding(.bottom, 25.0)
    }
}

#Preview {
    SignInButtonsStack(
        viewModel: SignInViewModel()
    )
}
