//
//  Created by funchar on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    


import URLRouting
import Foundation
import Moya

protocol NetTarget: TargetType {}

enum AuthenticationService: NetTarget {
    case signUp(SignUpViewModel)
    case login(SignInViewModel)
    case refresh
    
    public var path: String {
        switch self {
        case .signUp:
            return "/auth/signup"
        case .login:
            return "/auth/login"
        case .refresh:
            return "/auth/refresh"
        }
    }
    
    public var task: Task {
        switch self {
        case let .signUp(body):
            return .requestParameters(parameters: [
                "username": body.username,
                "password": body.password,
                "email": body.email,
                "fullName": body.username,
            ], encoding: JSONEncoding())
        case let .login(body):
            return .requestParameters(parameters: [
                "username": body.email,
                "password": body.password,
            ], encoding: JSONEncoding())
        case .refresh:
            return .requestPlain
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

extension NetTarget {
    public var baseURL: URL {
        URL(string: "http://localhost:5000")!
    }
}

