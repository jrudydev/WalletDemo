//
//  PassColorMapper.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import SwiftUI

enum PassColorMapper {
    static func color(for colorName: String) -> Color {
        switch colorName.lowercased() {
        case "blue":
            return .blue
        case "green":
            return .green
        case "red":
            return .red
        case "orange":
            return .orange
        case "purple":
            return .purple
        case "pink":
            return .pink
        case "yellow":
            return .yellow
        case "teal":
            return .teal
        case "indigo":
            return .indigo
        case "cyan":
            return .cyan
        case "mint":
            return .mint
        case "brown":
            return .brown
        case "gray", "grey":
            return .gray
        default:
            return .blue // Default fallback color
        }
    }
}
