//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import Foundation
import APIModelKit
import Moya

enum ProviderError: Error {
    case refreshTokenMissed
    case jsonMapError
}

public func refreshTokenStrategy(_ retry: @escaping () -> Void, fail: @escaping (Error) -> Void) {
    guard let token = AuthStore.shared.get(forKey: "refresh.token", type: String.self) else {
        ApplicationStore.shared.logout()
        fail(ProviderError.refreshTokenMissed)
        return
    }
    let provider = MoyaProvider<NetAuthService>()

    provider.request(.refresh(token)) { result in
        switch result {
        case .success(let response):
            if let response = try? response.map(RefreshTokenResponse.self) {
                AuthStore.shared.store(value: response.accessToken, forKey: "access.token")
                AuthStore.shared.store(value: response.refreshToken, forKey: "refresh.token")
                ApplicationStore.shared.forceUpdateSubviews()
                retry()
            } else {
                ApplicationStore.shared.logout()
            }
        case .failure(let error):
            fail(error)
        }
    }
}

public func AuthProvider<Target: TargetType>() -> MoyaProvider<Target> {
    MoyaProvider<Target>(
        plugins: [AccessTokenPlugin { _ in AuthStore.shared.get(forKey: "access.token", type: String.self) ?? "" }]
    )
}

public func BaseRequest<Target: TargetType, Response: Decodable>(
    _ target: Target,
    completion: @escaping (Result<Response, Error>) -> Void
) {
    let provider = MoyaProvider<Target>()

    provider.request(target) { result in
        switch result {
        case let .success(response):
            let value = try? response.map(Response.self)
            guard let value else {
                completion(.failure(ProviderError.jsonMapError))
                return
            }
            completion(.success(value))
        case let .failure(error):
            completion(.failure(error))
        }
    }
}

public func ApplicationRequest<Target: TargetType, Response: Decodable>(
    _ target: Target,
    provider: MoyaProvider<Target> = AuthProvider(),
    refreshStrategy: ((_ retry: @escaping () -> Void, _ fail: @escaping (Error?) -> Void) -> Void)? = refreshTokenStrategy,
    completion: @escaping (Result<Response, Error>) -> Void
) {
    provider.request(target) { result in
        switch result {
        case let .success(response) where response.statusCode == 401:
            refreshTokenStrategy {
                ApplicationRequest(target, provider: provider, refreshStrategy: nil, completion: completion)
            } fail: { failError in
                completion(.failure(failError))
            }
        case let .success(response):
            let value = try? response.map(Response.self)
            guard let value else {
                completion(.failure(ProviderError.jsonMapError))
                return
            }
            completion(.success(value))
        case let .failure(error):
            completion(.failure(error))
        }
    }
}
