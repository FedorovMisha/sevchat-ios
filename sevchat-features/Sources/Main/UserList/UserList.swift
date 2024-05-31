//
//  Created by frvmi on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    

import DaVinci
import Aesthetic
import NetSpark
import SwiftUI

public final class UserListViewModel: ObservableObject {

}

public struct UserListView: View {

    

    public var body: some View {
        NavigationStack {
            contentView
        }
    }

    private var contentView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(0..<100) { index in
                    UserCell(id: "", username: "\(index) username")
                }
            }
        }
        .padding(.horizontal, 16.0)
        .padding(.top, 12.0)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image.chatIS
            }
        }
        .searchable(text: .constant("asd;fkjasfd;"))
    }
}

#Preview {
    UserListView()
}
