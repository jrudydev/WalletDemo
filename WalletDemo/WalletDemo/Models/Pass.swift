//
//  Pass.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import Foundation

struct Pass: Identifiable, Codable {
    let id: String
    let type: PassType
    let merchantName: String
    var balance: Decimal
    let lastUsed: Date
    let color: String
    
    enum PassType: String, Codable {
        case credit, debit, gift, loyalty
    }
}
