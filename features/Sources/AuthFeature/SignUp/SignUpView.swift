//
//  File.swift
//  
//
//  Created by Misha Fedorov on 23.04.2024.
//

import Core
import SwiftUI

public class SignUpViewModel: ObservableObject {
    
    @Published
    public var username: String = ""
    
    @Published
    public var email: String = ""
   
    @Published
    public var confirmPassword: String = ""
    
    @Published
    public var password: String = ""
    
    @Published
    public var showSignError: Bool = false
    
    public var canSignIn: Bool {
        !email.isEmpty && !password.isEmpty
    }
}

public struct SignUpView: View {
    
    @StateObject
    private var model = SignUpViewModel()
    
    public var body: some View {
        VStack {
            Image(.chatIS)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 30)
                .padding(.top, 16)
            
            Text("Регистрация")
                .font(.h1)
                .foregroundStyle(Color(.h1))
                .padding(.vertical, 16.0)
            
            VStack(spacing: 15.0) {
                
                Input(
                    placeholder: "Имя",
                    value: $model.username,
                    icon: Image(.profile)
                )
                
                Input(
                    placeholder: "Почта",
                    value: $model.email,
                    icon: Image(.mail)
                )
                .keyboardType(.emailAddress)
                
                Input(
                    placeholder: "Пароль",
                    value: $model.password,
                    icon: Image(.password),
                    isSecure: true
                )
                
                Input(
                    placeholder: "Повторите пароль",
                    value: $model.confirmPassword,
                    icon: Image(.password),
                    isSecure: true
                )
            }
            
            Spacer()
            
            GradientButton(title: "Создать") {
                
            }
            .padding(.bottom, 16.0)
            
        }
        .padding(.horizontal, 24.0)
    }
    
    public init() { }
}

#Preview {
    SignUpView()
}
