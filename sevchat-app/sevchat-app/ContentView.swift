//
//  ContentView.swift
//  sevchat-app
//
//  Created by Misha Fedorov on 26.04.2024.
//

import SwiftUI
import DaVinci
import Authentication

struct ContentView: View {
    var body: some View {
        VStack {
            AuthenticationRoot()
        }

    }
}

#Preview {
    ContentView()
}
