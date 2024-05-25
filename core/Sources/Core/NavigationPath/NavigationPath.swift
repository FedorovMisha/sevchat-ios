import SwiftUI

public struct NavigationPath: Identifiable, Hashable {
   
    public let rawValue: String
    
    public var id: String {
        rawValue
    }
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}
