//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
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
        // TODO: отправить запрос на сервер
        // Обновить данные в auth manager
    }
}
