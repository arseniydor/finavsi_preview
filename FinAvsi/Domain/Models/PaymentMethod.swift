//
//  PaymentMethod.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import Foundation

enum PaymentMethod: String, Codable, CaseIterable {
    case cash = "Cash"
    case card = "Card"
}
