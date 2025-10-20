//
//  Constants.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import Foundation

enum AppConstants {
    static let cacheCapacity = 20
    static let networkTimeout: TimeInterval = 30.0
    static let maxConcurrentOperations = 5
}

enum MockDataConstants {
    static let merchants = ["Starbucks", "Whole Foods", "Apple Store", "Uber", "Amazon", "Netflix", "Target"]
    static let categories = ["Food", "Shopping", "Transport", "Entertainment", "Groceries"]
}
