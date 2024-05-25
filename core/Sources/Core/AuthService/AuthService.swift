import Moya
import CoreAPIModels

public enum AuthService {
    case signUp(SignUpModel)
    case signIn(LoginRequestModel)
    case refresh(_ token: String)
}

extension AuthService: TargetType {
    
    public var path: String {
        switch self {
        case .signIn:
            "auth/login"
        case .signUp:
            "auth/signup"
        case .refresh:
            "auth/refresh"
        }
    }
    
    public var method: Moya.Method {
        .post
    }
    
    public var task: Moya.Task {
        switch self {
        case .signUp(let signUpModel):
            Moya.Task.requestJSONEncodable(signUpModel)
        case .signIn(let loginRequestModel):
            Moya.Task.requestJSONEncodable(loginRequestModel)
        case .refresh:
            Moya.Task.requestPlain
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .refresh(let token):
            ["Refresh": token]
        default:
            nil
        }
    }
}
