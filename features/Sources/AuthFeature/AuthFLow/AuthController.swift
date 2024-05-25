import Core
import SwiftUI

public final class AuthNavigationState: ObservableObject {
    
    @Published
    var showSignUp: Bool = false
}

public struct AuthController: View {
    
    @StateObject
    private var state = AuthNavigationState()
    
    public var body: some View {
        NavigationStack {
            SignInView()
        }
        .environmentObject(state)
        .sheet(isPresented: $state.showSignUp) {
            SignUpView()
        }
    }
    
    public init() { }
}

extension Core.NavigationPath {
    public static let signUp = NavigationPath("io.sevsuchat.signup.basic")
}
