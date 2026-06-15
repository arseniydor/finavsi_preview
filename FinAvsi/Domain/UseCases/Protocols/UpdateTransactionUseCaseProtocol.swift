//
//  UpdateTransactionUseCaseProtocol.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

protocol UpdateTransactionUseCaseProtocol {
    func execute(transaction: Transaction) throws
}
