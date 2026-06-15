//
//  MonthSwitcherView.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SwiftUI

struct MonthSwitcherView: View {

    let title: String
    let onPrevious: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack {
            Button {
                onPrevious()
            } label: {
                Image(systemName: "chevron.left")
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.borderless)
            Spacer()
            Text(title)
                .font(.headline)
            Spacer()
            Button {
                onNext()
            } label: {
                Image(systemName: "chevron.right")
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.borderless)
        }
    }
}
