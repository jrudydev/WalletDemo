//
//  Transaction.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import Foundation

struct Transaction: Identifiable, Codable {
    let id: String
    let passId: String
    let merchantName: String
    let amount: Decimal
    let date: Date
    let category: String
}
