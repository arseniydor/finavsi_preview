//
//  SummaryRowView.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SwiftUI

struct SummaryRowView: View {

    let title: String
    let value: Double

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value, format: .currency(code: "EUR"))
                .bold()
        }
    }
}
