//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import SwiftUI
import Moya

final class SignInViewModel: ObservableObject, AlertHandling {

    @Published
    var email: String

    @Published
    var password: String
    
    @Published
    var alertState = AlertState()

    @Published
    var error: String?

    var isDisabledSignInButton: Bool {
        email.isEmpty || password.isEmpty
    }

    public init() {
        self.email = ""
        self.password = ""
        self.error = nil
    }

    public init(email: String, password: String, error: String) {
        self.email = email
        self.password = password
        self.error = error
    }

    public func onSignInTap() {
       
        MoyaProvider<AuthenticationService>()
            .request(.login(self)) { result in
            switch result {
            case let .success(response):
                debugData(response.data)
            case let .failure(error):
                self.alertState = AlertState(isPresented: true, localizedError: error)
            }
        }
    }
}
