//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import SwiftUI
import Foundation

public struct User: Codable, Identifiable, Hashable {
    public let username: String
    public let email: String
    public let fullName: String
    public let lastOnlineTime: Date?
    public let gender: String?
    public let avatarUrl: URL?
    public let phoneNumber: String?
    public let createdAt: String?
    public let updatedAt: String?
    public let deletedAt: String?
    public let id: String
}

extension User {
    public static let mock = User(username: "Some User", email: "some@some.com", fullName: "Some User", lastOnlineTime: nil, gender: nil, avatarUrl: nil, phoneNumber: nil, createdAt: nil, updatedAt: nil, deletedAt: nil, id: "ididid")
}
