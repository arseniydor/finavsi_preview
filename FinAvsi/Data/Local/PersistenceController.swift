//
//  PersistenceController.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import Foundation
import SwiftData

@MainActor
final class PersistenceContainer {

    let container: ModelContainer

    init(inMemory: Bool = false) {
        let schema = Schema([TransactionEntity.self])

        let configuration: ModelConfiguration

        if inMemory {
            configuration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: true
            )
        } else {
            let storeURL = Self.makeStoreURL()

            configuration = ModelConfiguration(
                schema: schema,
                url: storeURL
            )
        }

        do {
            self.container = try ModelContainer(
                for: schema,
                configurations: [configuration]
            )
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    var mainContext: ModelContext {
        container.mainContext
    }
}

private extension PersistenceContainer {

    static func makeStoreURL() -> URL {
        let fileManager = FileManager.default

        let applicationSupportURL = fileManager.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        )[0]

        do {
            try fileManager.createDirectory(
                at: applicationSupportURL,
                withIntermediateDirectories: true
            )
        } catch {
            fatalError("Failed to create Application Support directory: \(error)")
        }

        return applicationSupportURL.appendingPathComponent("FinAvsi.store")
    }
}
