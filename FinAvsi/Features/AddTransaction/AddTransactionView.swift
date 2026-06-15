//
//  AddTransactionView.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation
import SwiftUI

struct AddTransactionView: View {

    @StateObject private var viewModel: AddTransactionViewModel
    @EnvironmentObject private var router: AppRouter

    init(viewModel: AddTransactionViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Form {
            Section("Transaction") {
                TextField("Title", text: $viewModel.draft.title).accessibilityIdentifier("transactionTitleField")

                TextField(
                    "Amount",
                    value: $viewModel.draft.amount,
                    format: .number
                )
                .keyboardType(.decimalPad)
                .accessibilityIdentifier("transactionAmountField")
                
                TextField(
                    "Description",
                    text: Binding(
                        get: { viewModel.draft.description ?? "" },
                        set: { viewModel.draft.description = $0 }
                    )
                )
            }

            Section("Details") {
                Picker("Type", selection: $viewModel.draft.type) {
                    ForEach(TransactionType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }

                TextField("Category", text: $viewModel.draft.category).accessibilityIdentifier("transactionCategoryField")

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
        .navigationTitle("Add Transaction")
        .accessibilityIdentifier("addTransactionScreen")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    viewModel.save()
                    router.back()
                }.accessibilityIdentifier("saveTransactionButton")
            }
        }
    }
}
