//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import Aesthetic
import SwiftUI
import NetSpark
import APIModelKit
import Combine

public final class PersonalProfileViewModel: ObservableObject {

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

public struct PersonalProfileView: View {

    @StateObject
    private var vm = PersonalProfileViewModel()

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
            editableContent(user)
        }
    }

    private func editableContent(_ user: User) -> some View {
        VStack(spacing: 8) {
            AInput(
                value: .constant(user.fullName),
                icon: .profile,
                right: AnyView(
                    Image.solarCopyOutline
                        .onTapGesture {
                            UIPasteboard.general.string = user.fullName
                        }
                ),
                isEditable: false
            )

            AInput(
                value: .constant(user.email),
                icon: .mail,
                right: AnyView(
                    Image.solarCopyOutline
                        .onTapGesture {
                            UIPasteboard.general.string = user.fullName
                        }
                ),
                isEditable: false
            )
        }
    }
}

#Preview {
    TabView {
        PersonalProfileView()
    }
    .tabViewStyle(PageTabViewStyle())
}
