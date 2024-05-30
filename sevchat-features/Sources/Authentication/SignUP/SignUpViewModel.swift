//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.

import SwiftUI
import NetSpark
import Moya


final class SignUpViewModel: ObservableObject, AlertHandling {

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
    var alertState = AlertState()

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
        MoyaProvider<AuthenticationService>()
            .request(.signUp(self)) { result in
            switch result {
            case let .success(response):
                debugData(response.data)
            case let .failure(error):
                self.alertState = AlertState(isPresented: true, localizedError: error)
            }
        }
    }
}


func debugData(_ data: Data)  {
    print(try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed))
}
