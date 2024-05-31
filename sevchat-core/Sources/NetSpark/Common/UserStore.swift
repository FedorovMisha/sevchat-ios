//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import APIModelKit
import Combine

public final class ApplicationStore: ObservableObject {

    public static let shared = ApplicationStore()

    @Published
    public var activeUser: User?

    public var accessToken: String? {
        AuthStore.shared.get(forKey: "access.token", type: String.self)
    }

    public var refreshToken: String? {
        AuthStore.shared.get(forKey: "refresh.token", type: String.self)
    }

    public init(activeUser: User? = nil) {
        self.activeUser = activeUser
    }

    public func forceUpdateSubviews() {
        objectWillChange.send()
    }

    public func logout() {
        AuthStore.shared.remove(forKey: "access.token")
        AuthStore.shared.remove(forKey: "refresh.token")
        activeUser = nil
    }
}
