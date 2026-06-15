//
//  FinAvsiApp.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import SwiftUI
import SwiftData

@main
@MainActor
struct FinAvsiApp: App {

    private let persistenceContainer: PersistenceContainer
    private let appContainer: AppContainer

    init() {
        let isUITesting = ProcessInfo.processInfo.arguments.contains("-ui-testing")
        let persistenceContainer = PersistenceContainer(inMemory: isUITesting)

        self.persistenceContainer = persistenceContainer
        self.appContainer = AppContainer(
            modelContext: persistenceContainer.mainContext
        )
    }

    var body: some Scene {
        WindowGroup {
            RootView(container: appContainer)
        }
        .modelContainer(persistenceContainer.container)
    }
}
