//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import Aesthetic
import SwiftUI
import NetSpark
import APIModelKit
import Combine

public final class UserProfileViewModel: ObservableObject {
    
    @Published
    var user: User?

    private var bag = Set<AnyCancellable>()

    public init() {
        ApplicationStore.shared.$activeUser
            .sink { user in
                self.user = user
            }
            .store(in: &bag)
    }

    public func loaderUserIfNeeded() {
        ApplicationRequest(UserService.me) { (result: Result<User, Error>) in
            switch result {
            case .success(let user):
                ApplicationStore.shared.activeUser = user
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func logout() {
        ApplicationStore.shared.logout()
    }
}

public struct UserProfileView: View {

    @StateObject
    private var vm = UserProfileViewModel()

    public var body: some View {
        if let user = vm.user {
            contentView(user)
        } else {
            ProgressView()
                .progressViewStyle(.circular)
                .onAppear {
                    vm.loaderUserIfNeeded()
                }
        }
    }

    private func contentView(_ user: User) -> some View {
        NavigationStack {
            ProfileView(user)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        LogoutButton {
                            vm.logout()
                        }
                    }
                }
        }
    }
    
    private func ProfileView(_ user: User) -> some View {
        GenericProfileView(
            userName: user.fullName,
            status: "В сети"
        ) {
            VStack(spacing: 8) {
                AInput(value: .constant(user.fullName), icon: .profile)
                AInput(value: .constant(user.email), icon: .mail)

                AButton(title: "Изменить") {

                }
                .shadow(color: .black.opacity(0.05), radius: 50, y: 26)
            }
        }
    }

}

#Preview {
    TabView {
        UserProfileView()
    }
    .tabViewStyle(PageTabViewStyle())
}
