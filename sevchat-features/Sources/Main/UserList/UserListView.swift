//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.

import APIModelKit
import Foundation
import DaVinci
import Aesthetic
import NetSpark
import SwiftUI

public final class UserListViewModel: ObservableObject {

    @Published
    public var userList: [User] = []

    @Published
    public var searchText = ""

    public func fetchUsers() {
        ApplicationRequest(UserService.all) { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                self.userList = users
            case .failure(let error):
                print(error)
            }
        }
    }
}

public struct UserListView: View {
    
    @StateObject
    private var viewModel = UserListViewModel()

    public var body: some View {
        NavigationStack {
            Group {
                if viewModel.userList.isEmpty {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .onAppear {
                            viewModel.fetchUsers()
                        }
                } else {
                    contentView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image.chatIS
                }
            }
            .searchable(
                text: $viewModel.searchText,
                prompt: "Поиск..."
            )
            .navigationDestination(for: User.self) { user in
                UserProfileView(user)
            }
        }
    }

    private var userList: [User] {
        if !viewModel.searchText.isEmpty {
            return viewModel.userList.filter {
                $0.fullName.contains(viewModel.searchText)
            }
        }

        return viewModel.userList
    }

    private var contentView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(userList) { user in
                    NavigationLink(value: user) {
                        UserCell(
                            id: user.id,
                            username: user.fullName
                        )
                    }
                }
            }

        }
        .padding(.horizontal, 16.0)
        .padding(.top, 12.0)
        .refreshable {
            viewModel.fetchUsers()
        }

    }
}

#Preview {
    UserListView()
}
