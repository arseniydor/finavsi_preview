//
//  TestTransactionRepositoryFixture.swift
//  FinAvsiTests
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SwiftData
@testable import FinAvsi

@MainActor
final class TestTransactionRepositoryFixture {

    let persistence: PersistenceContainer
    let repository: TransactionRepositoryProtocol

    init() {
        self.persistence = PersistenceContainer(inMemory: true)
        self.repository = TransactionRepository(
            context: persistence.mainContext
        )
    }
}
