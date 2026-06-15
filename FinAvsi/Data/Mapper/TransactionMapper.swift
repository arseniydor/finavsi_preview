//
//  TransactionMapper.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import Foundation

struct TransactionMapper {

    func mapToDomain(_ entity: TransactionEntity) -> Transaction {
        Transaction(
            id: entity.id,
            amount: entity.amount,
            type: entity.type,
            category: entity.category,
            title: entity.title,
            description: entity.transactionDescription,
            paymentMethod: entity.paymentMethod,
            date: entity.date,
            createdAt: entity.createdAt,
            updatedAt: entity.updatedAt
        )
    }

    func mapToEntity(_ model: Transaction) -> TransactionEntity {
        TransactionEntity(
            id: model.id,
            amount: model.amount,
            type: model.type,
            category: model.category,
            title: model.title,
            description: model.description,
            paymentMethod: model.paymentMethod,
            date: model.date,
            createdAt: model.createdAt,
            updatedAt: model.updatedAt
        )
    }
    
    func updateEntity(_ entity: TransactionEntity, from model: Transaction) {
        entity.amount = model.amount
        entity.type = model.type
        entity.title = model.title
        entity.transactionDescription = model.description
        entity.paymentMethod = model.paymentMethod
        entity.date = model.date
        entity.updatedAt = Date()
    }
}
