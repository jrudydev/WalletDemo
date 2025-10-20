//
//  PassCard.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import SwiftUI

struct PassCard: View {
    let pass: Pass

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            PassCardHeader(pass: pass)
            Spacer()
            PassCardBalance(pass: pass)
            PassCardFooter(pass: pass)
        }
        .padding()
        .frame(width: 280, height: 180)
        .background(backgroundColor)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
    
    private var backgroundColor: Color {
        PassColorMapper.color(for: pass.color)
    }
}

private struct PassCardHeader: View {
    let pass: Pass
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(pass.type.rawValue.uppercased())
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.8))
                Text(pass.merchantName)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            Spacer()
            Image(systemName: "creditcard.fill")
                .foregroundColor(.white.opacity(0.5))
                .font(.title2)
        }
    }
}

private struct PassCardBalance: View {
    let pass: Pass
    
    var body: some View {
        Text(formattedBalance)
            .font(.title)
            .bold()
            .foregroundColor(.white)
    }
    
    private var formattedBalance: String {
        if pass.type == .loyalty {
            return "\(pass.balance) pts"
        }
        return "$\(pass.balance as NSDecimalNumber)"
    }
}

private struct PassCardFooter: View {
    let pass: Pass
    
    var body: some View {
        Text("Last used: \(pass.lastUsed, formatter: DateFormatters.short)")
            .font(.caption)
            .foregroundColor(.white.opacity(0.8))
    }
}
