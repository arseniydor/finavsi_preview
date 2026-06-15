//
//  CategoryAnalyticsRowView.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SwiftUI

struct CategoryAnalyticsRowView: View {

    let item: CategoryAnalytics

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.category)
                    .font(.headline)
                Text("\(item.transactionCount) transactions")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(item.amount, format: .currency(code: "EUR"))
                .bold()
        }
    }
}
