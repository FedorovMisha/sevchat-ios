import Foundation

public struct UserModel: Codable {
    let id: String
    
    let username: String
    let password: String
    let email: String
    let fullName: String
    let lastOnlineTime: String?
    let gender: String?
    let avatarURL: String?
    let phoneNumber: String?
}
