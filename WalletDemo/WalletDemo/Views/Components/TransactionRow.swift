//
//  TransactionRow.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.merchantName)
                    .font(.headline)
                Text("\(transaction.date, formatter: DateFormatters.short) • \(transaction.category)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("$\(abs(Int32(truncating: transaction.amount as NSDecimalNumber)))")
                .font(.headline)
                .foregroundColor(transaction.amount < 0 ? .red : .green)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}


struct SortButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(8)
        }
    }
}
