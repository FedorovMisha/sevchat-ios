//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import APIModelKit
import NetSpark
import SwiftUI
import DaVinci
import Aesthetic

private final class ChatListViewModel: ObservableObject {

    @Published
    var chats: [ChatModel] = []

    func fetchChats() {
        ApplicationRequest(ChatService.myChats) { (result: Result<[ChatModel], Error>) in
            switch result {
            case let .success(value):
                self.chats = value
            case let .failure(error):
                print(error)
            }
        }
    }
}

public struct ChatListView: View {

    @StateObject
    private var viewModel = ChatListViewModel()

    public var body: some View {
        NavigationStack {
            contentView
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image.chatIS
                    }
                }
        }
    }

    @ViewBuilder
    var contentView: some View {
        if viewModel.chats.isEmpty {
            ProgressView()
                .progressViewStyle(.circular)
                .onAppear {
                    viewModel.fetchChats()
                }
        } else {
            chatsView
        }
    }

    var chatsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.chats) { chat in
                    if let companion = chat.chatMembers.first { $0.id == ApplicationStore.shared.userId } { // TODO: поменять == на !=
                        ChatCell(chat: chat, companion: companion)
                    }
                }
            }
            .onAppear {
                print(ApplicationStore.shared.userId)
            }
        }
        .padding(.horizontal, 16)
    }
}

public struct ChatCell: View {

    let chat: ChatModel
    let companion: User

    public var body: some View {
        ZStack(alignment: .leading) {
            background
            content
        }
        .fixedSize(horizontal: false, vertical: true)
    }


    private let formatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()


    private var content: some View {
        HStack {
            avatar

            VStack(alignment: .leading) {
                Text(companion.username)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.cText)
                    .padding(.bottom, 4.0)

                if let message = chat.chatMessages.last {
                    Text(message.text)
                        .lineLimit(1)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.kText)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack {
                if let message = chat.chatMessages.last {
                    Text(formatter.string(from: message.createdAt))
                        .foregroundStyle(Color.kText)
                        .font(.system(size: 12))
                }
                Spacer()
            }
            .frame(alignment: .top)
            .frame(maxHeight: 48)

        }
        .padding(.horizontal, 16.0)
        .padding(.vertical, 16.0)
    }

    private var background: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.b)
    }

    private var avatar: some View {
        Circle()
            .fill(Color.c1)
            .frame(width: 48, height: 48)
            .overlay {
                Text(String(companion.username.first ?? "❌"))
            }
            .foregroundStyle(.white)
    }

    public init(chat: ChatModel, companion: User) {
        self.chat = chat
        self.companion = companion
    }
}

