//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import SwiftUI

public struct UserCell: View {

    public let id: String
    public let username: String

    public var body: some View {
        ZStack(alignment: .leading) {
            background
            content
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private var content: some View {
        HStack {
            avatar

            VStack(alignment: .leading) {
                Text(username)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.cText)

                Text("В сети")
                    .font(.system(size: 12))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.Gradient.c1, .Gradient.c2],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
        }
        .padding(.horizontal, 16.0)
        .padding(.vertical, 10.0)
    }

    private var background: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.b)
    }

    private var avatar: some View {
        Circle()
            .fill(Color.c1)
            .frame(width: 32, height: 32)
            .overlay {
                Text(String(username.first ?? "❌"))
            }
            .foregroundStyle(.white)
    }

    public init(id: String, username: String) {
        self.id = id
        self.username = username
    }
}

#Preview {
    UserCell(
        id: "id", username: "Nikolas"
    )
}
