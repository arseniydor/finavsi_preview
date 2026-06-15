//
//  EditTransactionView.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation
import SwiftUI

struct EditTransactionView: View {

    @StateObject private var viewModel: EditTransactionViewModel
    @EnvironmentObject private var router: AppRouter

    init(viewModel: EditTransactionViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Form {
            Section("Transaction") {
                TextField("Title", text: $viewModel.draft.title)

                TextField(
                    "Amount",
                    value: $viewModel.draft.amount,
                    format: .number
                )
                .keyboardType(.decimalPad)

                TextField(
                    "Description",
                    text: Binding(
                        get: { viewModel.draft.description ?? "" },
                        set: { viewModel.draft.description = $0.isEmpty ? nil : $0 }
                    )
                )
            }

            Section("Details") {
                Picker("Type", selection: $viewModel.draft.type) {
                    ForEach(TransactionType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }

                TextField("Category", text: $viewModel.draft.category)

                Picker("Payment Method", selection: $viewModel.draft.paymentMethod) {
                    ForEach(PaymentMethod.allCases, id: \.self) { method in
                        Text(method.rawValue).tag(method)
                    }
                }

                DatePicker(
                    "Date",
                    selection: $viewModel.draft.date,
                    displayedComponents: .date
                )
            }

            if let errorMessage = viewModel.errorMessage {
                Section {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Edit Transaction")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    let success = viewModel.save()

                    if success {
                        router.back()
                    }
                }
            }
        }
    }
}
