//
//  ContentView.swift
//  sevchat-app
//
//  Created by Misha Fedorov on 26.04.2024.
//

import SwiftUI
import DaVinci

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")

        }
        .padding()
        .onAppear {
            let b = Bundle.main.infoDictionary?["BASE_URL"]
            print(b)
        }
    }
}

#Preview {
    ContentView()
}
