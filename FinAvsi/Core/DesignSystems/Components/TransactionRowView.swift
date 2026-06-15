//
//  TransactionRowView.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SwiftUI

struct TransactionRowView: View {

    let transaction: Transaction

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.headline)
                Text(transaction.category)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(transaction.amount, format: .currency(code: "EUR"))
                .font(.headline)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(
            "transaction_\(transaction.title)"
        )
    }
}
