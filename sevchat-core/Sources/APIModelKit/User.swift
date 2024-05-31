//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import SwiftUI
import Foundation

public final class User: Codable, ObservableObject {
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

