//
//  TabNavigationView.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import SwiftUI

struct TabNavigationView<Root: View, Destination: View>: View {
    @Binding var path: [AppRoute]
    
    let tabTitle: String
    let tabImage: String
    let tag: AppTab
    let root: Root
    let destination: (AppRoute) -> Destination
    
    var body: some View {
        NavigationStack(path: $path) {
            root.navigationDestination(for: AppRoute.self) { route in
                destination(route)
            }
        }.tabItem {
            Label(tabTitle, systemImage: tabImage)
        }.tag(tag)
    }
}
