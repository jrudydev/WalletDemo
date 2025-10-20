//
//  MockDataGenerator.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import Foundation

enum MockDataGenerator {
    static func generatePasses() -> [Pass] {
        [
            Pass(id: "1", type: .credit, merchantName: "Chase Sapphire",
                 balance: 5420.50, lastUsed: Date().addingTimeInterval(-86400), color: "blue"),
            Pass(id: "2", type: .debit, merchantName: "Wells Fargo",
                 balance: 1250.00, lastUsed: Date().addingTimeInterval(-172800), color: "green"),
            Pass(id: "3", type: .gift, merchantName: "Starbucks",
                 balance: 45.00, lastUsed: Date().addingTimeInterval(-432000), color: "emerald"),
            Pass(id: "4", type: .loyalty, merchantName: "Hilton Honors",
                 balance: 125000, lastUsed: Date().addingTimeInterval(-864000), color: "amber"),
            Pass(id: "5", type: .credit, merchantName: "Amex Gold",
                 balance: 3200.00, lastUsed: Date().addingTimeInterval(-259200), color: "orange")
        ]
    }
    
    static func generateTransactions() -> [Transaction] {
        (0..<50).map { i in
            let passId = String(Int.random(in: 1...5))
            let date = Date().addingTimeInterval(-Double.random(in: 0...2592000))
            let amount = Decimal(-Double.random(in: 5...200))
            
            return Transaction(
                id: "t\(i)",
                passId: passId,
                merchantName: MockDataConstants.merchants.randomElement()!,
                amount: amount,
                date: date,
                category: MockDataConstants.categories.randomElement()!
            )
        }
    }
}
