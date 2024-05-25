//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import SwiftUI

public struct ANavigationPath: Hashable, Identifiable {

    public let value: String

    public var id: String {
        value
    }

    public init(_ value: String) {
        self.value = "com.navigation.path.\(value)"
    }
}

public final class NavigationObject: ObservableObject {

    @Published
    public var views: [ANavigationPath]

    @Published
    public var sheet: ANavigationPath?

    public init(_ views: [ANavigationPath]) {
        self.views = views
    }

    public func push(_ view: ANavigationPath) {
        views.append(view)
    }

    public func sheet(_ view: ANavigationPath) {
        sheet = view
    }

    public func pop() {
        views.removeLast()
    }
}

