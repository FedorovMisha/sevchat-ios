//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import APIModelKit
import Moya
import SwiftUI

public enum NetAuthService {
    case signUp(SignUpRequestModel)
    case signIn(SignInRequestModel)
    case refresh(_ token: String)
}

extension NetAuthService: NetTarget {
    public var path: String {
        switch self {
        case .signUp(_):
            "/auth/signup"
        case .signIn(_):
            "/auth/login"
        case .refresh(_):
            "/auth/refresh"
        }
    }

    public var method: Moya.Method {
        .post
    }
    
    public var task: Moya.Task {
        switch self {
        case .signUp(let signUpRequestModel):
            Moya.Task.requestJSONEncodable(signUpRequestModel)
        case .signIn(let signInRequestModel):
            Moya.Task.requestJSONEncodable(signInRequestModel)
        case .refresh(_):
            .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .signUp(_), .signIn(_):
            nil
        case .refresh(let token):
            ["Authorization": "Refresh \(token)"]
        }
    }
}
