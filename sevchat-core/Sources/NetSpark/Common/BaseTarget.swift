//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import Foundation
import Moya
import APIModelKit

public protocol NetTarget: TargetType {

    
}

extension NetTarget {
    public var baseURL: URL {
        URL(string: Bundle.main.infoDictionary?["BASE_URL"] as! String)!
    }
}

public final class AuthStore {

    public static let shared = AuthStore()

    private init() {}

    // Метод для сохранения данных
    public func store<T>(value: T, forKey key: String) where T: Codable {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(value) {
            defaults.set(encoded, forKey: key)
        }
    }

    // Метод для получения данных
    public func get<T>(forKey key: String, type: T.Type) -> T? where T: Codable {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: key),
           let decoded = try? JSONDecoder().decode(T.self, from: data) {
            return decoded
        }
        return nil
    }

    // Метод для удаления данных
    public func remove(forKey key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
}
