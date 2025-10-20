//
//  TransactionProcessor.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import Foundation

class TransactionProcessor {
    
    enum SortOption {
        case date, amount, merchant
    }
    
    // Filter and sort transactions - demonstrates algorithm composition
    static func processTransactions(
        _ transactions: [Transaction],
        searchQuery: String = "",
        sortBy: SortOption = .date
    ) -> [Transaction] {
        var filtered = transactions
        
        // Filter by search query - O(n)
        if !searchQuery.isEmpty {
            let query = searchQuery.lowercased()
            filtered = filtered.filter {
                $0.merchantName.lowercased().contains(query) ||
                $0.category.lowercased().contains(query)
            }
        }
        
        // Sort using Swift's optimized sort (Timsort-based)
        switch sortBy {
        case .date:
            filtered.sort { $0.date > $1.date }
        case .amount:
            filtered.sort {
                let amount0 = ($0.amount as NSDecimalNumber).decimalValue
                let amount1 = ($1.amount as NSDecimalNumber).decimalValue
                let absAmount0 = amount0 < 0 ? -amount0 : amount0
                let absAmount1 = amount1 < 0 ? -amount1 : amount1
                return absAmount0 > absAmount1
            }
        case .merchant:
            filtered.sort { $0.merchantName < $1.merchantName }
        }
        
        return filtered
    }
    
    // Calculate statistics - demonstrates data aggregation
    static func calculateStats(_ transactions: [Transaction]) -> TransactionStats {
        guard !transactions.isEmpty else {
            return TransactionStats(total: 0, count: 0, average: 0, topCategory: "N/A")
        }
        
        let total = transactions.reduce(Decimal(0)) { $0 + $1.amount }
        let average = total / Decimal(transactions.count)
        
        // Find top category using dictionary aggregation - O(n)
        var categoryTotals: [String: Decimal] = [:]
        for transaction in transactions {
            categoryTotals[transaction.category, default: 0] += abs(transaction.amount)
        }
        
        let topCategory = categoryTotals.max { $0.value < $1.value }?.key ?? "N/A"
        
        return TransactionStats(
            total: total,
            count: transactions.count,
            average: average,
            topCategory: topCategory
        )
    }
}
