//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import APIModelKit
import SwiftUI
import NetSpark

public final class MainUserViewModel: ObservableObject {

    public static let shared = MainUserViewModel()

    @Published
    private(set) var user: User?

    public init(user: User? = nil) {
        self.user = user
    }

    func update() {
        user = AuthStore.shared.get(forKey: "user.model", type: User.self)
    }
}
