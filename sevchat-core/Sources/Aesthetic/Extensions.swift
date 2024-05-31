//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import SwiftUI

extension View {

    @ViewBuilder 
    public func applyIf<V: View>(
        _ condition: Bool,
        transform: (Self) -> V
    ) -> some View {

        if condition {
            transform(self)
        } else {
            self
        }
    }
}

