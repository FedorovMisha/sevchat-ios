//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import Aesthetic
import SwiftUI

public struct AuthenticationRoot: View {

    @StateObject
    private var navigation = NavigationObject([])

    public var body: some View {
        NavigationStack(path: $navigation.views) {
            SignUpView()
                .sheet(item: $navigation.sheet) { value in
                    switch value {
                    case .signUp:
                        SignUpView()
                    default:
                        EmptyView()
                    }
                }
        }
        .environmentObject(navigation)
    }

    public init() {

    }
}

#Preview {
    AuthenticationRoot()
}
