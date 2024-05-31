//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import Foundation

/// Endpoint: http://localhost:8080/auth/signup
/// 
/// {
///     "username": "User 1",
///     "password": "qwerty12345",
///     "email": "test1@test.com",
///     "fullName": "Test User 1"
/// }
public struct SignUpRequestModel: Codable {
    public let username: String
    public let password: String
    public let email: String
    public let fullName: String

    public init(
        username: String,
        password: String,
        email: String,
        fullname: String
    ) {
        self.username = username
        self.password = password
        self.email = email
        self.fullName = fullname
    }
}

public struct SignUpResponseModel: Codable {
    public let user: User

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.user = try container.decode(User.self)
    }
}
