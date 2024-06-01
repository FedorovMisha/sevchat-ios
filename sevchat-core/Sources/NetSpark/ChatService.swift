//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import Foundation
import APIModelKit
import Moya

public enum ChatService {
    case getOrCreate(_ withUser: String)
    case messages(_ id: String)
    case myChats
    case sendMessage(SendMessageModel)
}

extension ChatService: NetTarget, AccessTokenAuthorizable {
    public var path: String {
        switch self {
        case .getOrCreate(let id):
            "chats/get-or-create/\(id)"
        case .messages(let id):
            "chats/messages/\(id)"
        case .myChats:
            "chats/my-chats"
        case .sendMessage:
            "chats/send-message"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getOrCreate:
            .get
        case .messages:
            .get
        case .myChats:
            .get
        case .sendMessage:
            .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .getOrCreate:
            return .requestPlain
        case .messages:
            return .requestPlain
        case .myChats:
            return .requestPlain
        case .sendMessage(let model):
            return .requestJSONEncodable(model)
        }
    }
    
    public var headers: [String : String]? {
        [:]
    }

}

public struct SendMessageModel: Codable {
    public let text: String
    public let chatId: String

    public init(text: String, chatId: String) {
        self.text = text
        self.chatId = chatId
    }
}

public struct ChatMessage: Codable, Identifiable, Hashable {
    public let id: String
    public let text: String
    public let createdAt: Date
    public let user: User?

//    public init(id: String, text: String, user: User?) {
//        self.id = id
//        self.text = text
//        self.user = user
//    }
}

public struct ChatModel: Codable, Identifiable, Hashable {
    public var chatMembers: [User]
    public let id: String
    public var chatMessages: [ChatMessage]
}
