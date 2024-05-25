import Core
import CoreAPIModels
import SwiftUI
import Moya

public class SignInViewModel: ObservableObject {
   
    @Published
    public var email: String = ""
    
    @Published
    public var password: String = ""
    
    @Published
    public var showSignError: Bool = false
    
    @Published
    public var user: UserModel?
    
    public var canSignIn: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    public func onSignInTap() {
        let provider = MoyaProvider<AuthService>()
        
        provider.request(
            .signIn(
                .init(
                    username: email,
                    password: password
                )
            )
        ) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let responseModel = try filteredResponse.map(LoginResponseModel.self)
                    self.user = responseModel.user
                }
                catch let error {
                    print(error)
                }
            case .failure(_):
                self.showSignError = true
                
            }
        }
    }
}

public struct SignInView: View {
    
    @StateObject
    private var model = SignInViewModel()
    
    public var body: some View {
        VStack {
            Spacer()
            
            Text("Добро пожаловать")
                .font(.h1)
                .foregroundStyle(Color(.h1))
                .padding(.bottom, 42.0)
            
            Input(
                placeholder: "Почта",
                value: $model.email,
                icon: Image(.mail)
            )
            .keyboardType(.emailAddress)
            .padding(.bottom, 15.0)
            
            Input(
                placeholder: "Пароль",
                value: $model.password,
                icon: Image(.password),
                isSecure: true
            )
            
            Spacer()
            
            SignInButtonsStack(viewModel: model)
        }
        .padding(.horizontal, 24.0)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(.chatIS)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 30)
            }
        }
    }
    
    public init() { }
}

#Preview {
    SignInView()
}
