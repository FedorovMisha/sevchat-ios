import Foundation

// MARK: - LoginResponseModel
public struct LoginResponseModel: Codable {
    public let user: UserModel
    public let backendTokens: BackendTokens
}

// MARK: - BackendTokens
public struct BackendTokens: Codable {
    public let accessToken: String
    public let refreshToken: String
    public let expiresIn: Int
}
