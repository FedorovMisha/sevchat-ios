//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import NetSpark
import APIModelKit
import SwiftUI

final class SignInViewModel: ObservableObject {

    @Published
    var email: String

    @Published
    var password: String

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
        let model = SignInRequestModel(username: email, password: password)
        BaseRequest(NetAuthService.signIn(model)) { (result: Result<SignInResponse, Error>) in
            switch result {
            case .success(let success):
                self.saveData(success)
            case .failure(let failure):
                self.error = "\(failure)"
            }
        }
    }

    public func saveData(_ data: SignInResponse) {
        AuthStore.shared.store(value: data.accessToken, forKey: "access.token")
        AuthStore.shared.store(value: data.accessToken, forKey: "refresh.token")
        ApplicationStore.shared.forceUpdateSubviews()
    }
}
