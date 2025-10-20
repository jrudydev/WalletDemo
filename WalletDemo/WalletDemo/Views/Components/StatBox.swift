//
//  StatBox.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import SwiftUI

struct StatBox: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
            Text(value)
                .font(.caption)
                .bold()
                .foregroundColor(color)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
