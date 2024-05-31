//
//  Created by mishafedorov on 2024.
//  Copyright © 2024 SevChatIS. All rights reserved.
    
import Aesthetic
import Authentication
import SwiftUI
import NetSpark

public struct MainEntryPoint: View {

    @StateObject
    public var aStore = ApplicationStore.shared

    public var body: some View {
        if aStore.accessToken != nil && aStore.refreshToken != nil {
            MainView()
                .environmentObject(aStore)
        } else {
            AuthenticationRoot()
                .environmentObject(aStore)
        }
    }

    public init() { }
}

public struct MainView: View {

    @State
    private var tabIndex = 0

    public var body: some View {
        VStack(spacing: .zero) {
            TabView(selection: $tabIndex) {
                UserListView()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(0)

                Color.pink
                    .overlay {
                        Text("Empty")
                    }
                    .tag(1)

                UserProfileView()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(2)
            }

            TabBar(selectedIndex: $tabIndex)
        }
        .animation(.easeInOut, value: tabIndex)
    }

    public init() { }
}

private struct TabBar: View {

    @Binding
    var selectedIndex: Int

    @Namespace
    private var namespace

    var body: some View {
        UnevenRoundedRectangle(topLeadingRadius: 24, topTrailingRadius: 24)
            .trim(from: 0.5, to: 1)
            .stroke(Color.TabBar.border, style: .init(lineWidth: 1.0))
            .frame(maxHeight: 56)
            .overlay {
                tabBarItems
            }
    }


    private var tabBarItems: some View {
        HStack {
            TabBarItem(Image.tabProfile, index: 0)
            Spacer()
            TabBarItem(Image.messages, index: 1)
            Spacer()
            TabBarItem(Image.settings, index: 2)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 58)
    }

    private var selectionFlag: some View {
        RoundedRectangle(cornerRadius: 100)
            .fill(itemGradient)
            .frame(width: 26.0, height: 2)
            .shadow(color: .TabBar.flagShadow, radius: 10)
    }

    private var itemGradient: LinearGradient {
        LinearGradient(
            colors: [.TabBar.c1, .TabBar.c2],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private func TabBarItem(_ icon: Image, index: Int) -> some View {
        VStack {
            if selectedIndex == index {
                selectionFlag
                    .matchedGeometryEffect(id: "com.chatsevsu.selectionflag.animation", in: namespace)
            } else {
                EmptyView()
            }
            Spacer()

            icon
                .applyIf(selectedIndex == index) { view in
                    view
                        .foregroundStyle(itemGradient)
                }
                .applyIf(selectedIndex != index) { view in
                    view.foregroundStyle(Color.TabBar.unselectedFlag)
                }
                .onTapGesture {
                    selectedIndex = index
                }
            
        }
    }
}

private struct TabBarHidden: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var tabBarHidden: Bool {
        get { self[TabBarHidden.self] }
        set { self[TabBarHidden.self] = newValue }
    }
}

#Preview {
    MainEntryPoint()
}
