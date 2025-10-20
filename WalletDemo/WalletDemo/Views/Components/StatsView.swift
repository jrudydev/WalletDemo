//
//  StatsView.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import SwiftUI

struct StatsView: View {
    let stats: TransactionStats
    
    var body: some View {
        HStack(spacing: 12) {
            StatBox(title: "Total", value: "$\(abs(Int32(truncating: stats.total as NSDecimalNumber)))", color: .red)
            StatBox(title: "Count", value: "\(stats.count)", color: .blue)
            StatBox(title: "Avg", value: "$\(abs(Int32(truncating: stats.average as NSDecimalNumber)))", color: .purple)
            StatBox(title: "Top", value: stats.topCategory, color: .green)
        }
    }
}
