//
//  AddTransactionViewModel.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Combine
import Foundation

@MainActor
final class AddTransactionViewModel: ObservableObject {
    
    @Published var draft = TransactionDraft()
    @Published var errorMessage: String?

    private let addTransactionUseCase: AddTransactionUseCaseProtocol

    init(addTransactionUseCase: AddTransactionUseCaseProtocol) {
        self.addTransactionUseCase = addTransactionUseCase
    }

    func save() {
        let transaction = Transaction(draft: draft)
        do {
            try addTransactionUseCase.execute(
                transaction: transaction
            )
        } catch {
            errorMessage = "Failed to save transction"
        }
    }
}
