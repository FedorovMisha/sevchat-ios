//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import Aesthetic
import NetSpark
import DaVinci
import APIModelKit
import SwiftUI

public class ChatViewModel: ObservableObject {

    @Published
    public var searchText: String = ""

    @Published
    public var messageText: String = ""

    @Published
    public var chat: ChatModel

    public var currentUserId: String? {
        ApplicationStore.shared.userId
    }

    public var companionName: String? {
        chat.chatMembers.first { u in
            u.id != currentUserId ?? ""
        }?.fullName
    }

    public var messages: [ChatMessage] {
        chat.chatMessages
            .filter { searchText.isEmpty ? true : $0.text.lowercased().contains(searchText.lowercased()) }
            .sorted { $0.createdAt < $1.createdAt }
    }

    public init(chat: ChatModel) {
        self.chat = chat
    }

    public func sendMessage(_ message: String) {
        guard !message.isEmpty else {
            return
        }

        ApplicationRequest(ChatService.sendMessage(SendMessageModel(text: message, chatId: chat.id))) { (result: Result<ChatMessage, Error>) in
            switch result {
            case .success(let message):
                self.chat.chatMessages.append(message)
            case .failure(let failure):
                print(failure)
            }
        }

        messageText = ""
    }
}

public struct ChatView: View {

    @StateObject
    private var viewModel: ChatViewModel

    @State
    private var showSearch = false

    @Environment(\.dismiss)
    private var dismiss

    public var body: some View {
        VStack {
            ScrollView {
                messages
            }
            .padding(.top, 14)
            .navigationBarTitleDisplayMode(.inline)
            .applyIf(showSearch) { view in
                view
                    .searchable(
                        text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Поиск..."
                    )
            }
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image.chatIS
                }

                ToolbarItem(placement: .topBarLeading) {
                    Image.cBack
                        .onTapGesture {
                            dismiss()
                        }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Image.search
                        .onTapGesture {
                            showSearch.toggle()
                        }
                }
            }
            .animation(.easeInOut, value: showSearch)

            bottomBar
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
    }

    private var messages: some View {
        ScrollViewReader { proxy in
            LazyVStack(spacing: 8.0){
                ForEach(viewModel.messages) { message in
                    HStack {
                        if message.user?.id == viewModel.currentUserId {
                            Spacer()
                        }

                        MessageView(message: message)
                            .id(message.id)

                        if message.user?.id != viewModel.currentUserId {
                            Spacer()
                        }
                    }
                }
            }
        }
    }

    private var bottomBar: some View {
        HStack {
            AInput(value: $viewModel.messageText, placeholder: "Сообщение...", axis: .vertical)
            Button {
                viewModel.sendMessage(viewModel.messageText)
            } label: {
                Image.uilMessage
                    .padding(6.0)
                    .overlay {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.Gradient.c1.opacity(0.1), .Gradient.c2.opacity(0.1)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
            }
        }
    }

    public init(chat: ChatModel) {
        self._viewModel = StateObject(wrappedValue: ChatViewModel(chat: chat))
    }
}

public struct MessageView: View {

    let message: ChatMessage

    private let formatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()


    public var body: some View {
        VStack {
            Text(message.text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.cText)
                .font(.system(size: 16, weight: .semibold))

            Text(formatter.string(from: message.createdAt))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundStyle(Color.kText)
                .font(.system(size: 14, weight: .semibold))
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 16)
        .frame(maxWidth: 240)
        .background(
            LinearGradient(
                colors: [.Gradient.c1.opacity(0.07), .Gradient.c2.opacity(0.07)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        .padding(.horizontal, 16)
    }
}
