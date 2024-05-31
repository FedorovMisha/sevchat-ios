//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.

import APIModelKit
import NetSpark
import SwiftUI

final class SignUpViewModel: ObservableObject {

    @Published
    var username: String

    @Published
    var email: String

    @Published
    var password: String

    @Published
    var confirmPassword: String

    @Published
    var error: String?

    @Published
    var signUpCompleted = false

    var isDisabledSignInButton: Bool {
        username.isEmpty || confirmPassword.isEmpty || email.isEmpty || password.isEmpty
    }

    public init() {
        self.email = ""
        self.password = ""
        self.username = ""
        self.confirmPassword = ""
        self.error = nil
    }

    public init(
        username: String = "",
        email: String,
        password: String,
        confirmPassword: String = "",
        error: String
    ) {
        self.username = username
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        self.error = error
    }

    public func onSignInTap() {
        let model = SignUpRequestModel(
            username: username,
            password: password,
            email: email,
            fullname: username
        )
        BaseRequest(NetAuthService.signUp(model)) { (result: Result<SignUpResponseModel, Error>) in
            switch result {
            case .success(_):
                self.signUpCompleted = true
            case .failure(let failure):
                print(failure)
                self.signUpCompleted = false
            }
        }
    }
}
