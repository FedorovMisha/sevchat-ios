//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import Moya

public enum UserService {
    case me
}

extension AccessTokenAuthorizable {
    public var authorizationType: Moya.AuthorizationType? {
        .bearer
    }
}

extension UserService: NetTarget, AccessTokenAuthorizable {

    public var path: String {
        "/auth/me"
    }
    
    public var method: Moya.Method {
        .get
    }
    
    public var task: Moya.Task {
        .requestPlain
    }
    
    public var headers: [String : String]? {
        [:]
    }
}
