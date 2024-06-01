//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import Aesthetic
import APIModelKit
import NetSpark
import Foundation
import SwiftUI

public final class UserProfileViewModel: ObservableObject {

    @Published
    public var user: User

    @Published
    public var chatModel: ChatModel?

    public init(user: User) {
        self.user = user
    }

    public func writeToUser() {
        ApplicationRequest(ChatService.getOrCreate(user.id)) { (result: Result<ChatModel, Error>) in
            switch result {
            case .success(let model):
                self.chatModel = model
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

struct UserProfileView: View {

    @StateObject
    private var viewModel: UserProfileViewModel

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var presentChat = false

    var body: some View {
        GenericProfileView(
            userName: viewModel.user.fullName,
            status: "В сети",
            gradient: gradient
        ) {
            contentView
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image.back
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }

    private var gradient: Gradient {
        Gradient(
            stops: [
                .init(color: .Gradient.c2, location: 0.39),
                .init(color: .Gradient.c3, location: 0.98)
            ]
        )
    }

    private var contentView: some View {
        VStack(spacing: 8) {
            AInput(
                value: .constant(viewModel.user.fullName),
                icon: .profile,
                right: AnyView(
                    Image.solarCopyOutline
                        .onTapGesture {
                            UIPasteboard.general.string = viewModel.user.fullName
                        }
                ),
                isEditable: false
            )

            AInput(
                value: .constant(viewModel.user.email),
                icon: .mail,
                right: AnyView(
                    Image.solarCopyOutline
                        .onTapGesture {
                            UIPasteboard.general.string = viewModel.user.fullName
                        }
                ),
                isEditable: false
            )
            .padding(.bottom, 28.0)

            Button {
                viewModel.writeToUser()
            } label: {
                Label {
                    Text("Написать")
                        .foregroundStyle(.white)
                        .padding(.vertical, 17.0)
                } icon: {
                    Image.write
                }
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [.Gradient.c1, .Gradient.c2],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .shadow(color: .black.opacity(0.05), radius: 50, y: 26)
        }
        .onChange(of: viewModel.chatModel) {
            guard $0 != nil else {
                return
            }

            presentChat = true
        }
        .fullScreenCover(item: $viewModel.chatModel) { chatModel in
            NavigationStack {
                ChatView(chat: chatModel)
                    .transition(.move(edge: .leading))
            }
        }
    }

    public init(_ user: User) {
        self._viewModel = StateObject(
            wrappedValue: UserProfileViewModel(user: user)
        )
    }
}

#Preview {
    UserProfileView(User.mock)
        .environmentObject(TabBarOptions())
}
