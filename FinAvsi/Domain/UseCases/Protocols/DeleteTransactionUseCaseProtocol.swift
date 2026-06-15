//
//  DeleteTransactionUseCaseProtocol.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

protocol DeleteTransactionUseCaseProtocol {
    func execute(id: UUID) throws
}
