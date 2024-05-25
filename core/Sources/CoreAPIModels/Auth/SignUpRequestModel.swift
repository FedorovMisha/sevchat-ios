import Foundation

public struct SignUpModel: Codable {

    public let username: String
    public let password: String
    public let fullname: String
    public let email: String
    
    public init(
        username: String,
        password: String,
        fullname: String,
        email: String
    ) {
        self.username = username
        self.password = password
        self.fullname = fullname
        self.email = email
    }
}
