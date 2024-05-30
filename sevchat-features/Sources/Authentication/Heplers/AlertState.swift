//
//  Created by funchar on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import SwiftUI
import Moya

struct AlertState {
    var isPresented = false
    var localizedError: MoyaError?
}

protocol AlertHandling {
    var alertState: AlertState { get set }
}

extension View {
    func alert<T: AnyObject & AlertHandling>(viewModel: T) -> some View {
        var viewModel = viewModel
        return self
            .alert(isPresented: Binding(get: {
            viewModel.alertState.isPresented
        }, set: {
            viewModel.alertState.isPresented = $0
        })
        , error: viewModel.alertState.localizedError
        ) {
            Button("Ok", role: .cancel, action: {})
        }
    }
}
