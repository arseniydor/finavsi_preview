//
//  EditTransactionViewModel.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Combine

@MainActor
final class EditTransactionViewModel: ObservableObject {

    @Published var draft: TransactionDraft
    @Published var errorMessage: String?

    private let transaction: Transaction
    private let updateTransactionUseCase: UpdateTransactionUseCaseProtocol

    init(transaction: Transaction, updateTransactionUseCase: UpdateTransactionUseCaseProtocol) {
        self.transaction = transaction
        self.draft = TransactionDraft(transaction: transaction)
        self.updateTransactionUseCase = updateTransactionUseCase
    }

    func save() -> Bool {
        let updatedTransaction = Transaction(
            existing: transaction,
            draft: draft
        )

        do {
            try updateTransactionUseCase.execute(
                transaction: updatedTransaction
            )
            return true
        } catch {
            errorMessage = "Failed to update transaction"
            return false
        }
    }
}
