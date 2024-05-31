//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

public struct SignInRequestModel: Codable {

    public let username: String
    public let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

public struct SignInResponse: Decodable {

    enum CodingKeys: String, CodingKey {
        case user
        case backendTokens
    }

    enum BackendTokenCodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
    }

    public let user: User

    public let accessToken: String
    public let refreshToken: String

    public init(from decoder: any Decoder) throws {
        let outer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try outer.nestedContainer(
            keyedBy: BackendTokenCodingKeys.self,
            forKey: .backendTokens
        )

        self.user = try outer.decode(User.self, forKey: .user)

        accessToken = try container.decode(
            String.self,
            forKey: .accessToken
        )

        refreshToken = try container.decode(
            String.self,
            forKey: .refreshToken
        )
    }
}

public struct RefreshTokenResponse: Decodable {
    public let accessToken: String
    public let refreshToken: String
}
