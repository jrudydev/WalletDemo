//
//  WalletViewModel.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import Foundation
import SwiftUI

@MainActor
class WalletViewModel: ObservableObject {
    @Published var passes: [Pass] = []
    @Published var transactions: [Transaction] = []
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var sortOption: TransactionProcessor.SortOption = .date
    @Published var selectedPassId: String?
    @Published var cacheSize = 0
    
    private let dataManager: DataManager
    private let transactionProcessor: TransactionProcessor
    
    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
        self.transactionProcessor = TransactionProcessor()
    }
    
    var filteredTransactions: [Transaction] {
        TransactionProcessor.processTransactions(
            transactions,
            searchQuery: searchText,
            sortBy: sortOption
        )
    }
    
    var stats: TransactionStats {
        TransactionProcessor.calculateStats(filteredTransactions)
    }
    
    func loadPasses() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            passes = try await dataManager.fetchPasses()
            cacheSize = await dataManager.cacheSize
        } catch {
            print("Error loading passes: \(error)")
        }
    }
    
    func loadTransactions(for passId: String) async {
        isLoading = true
        selectedPassId = passId
        defer { isLoading = false }
        
        do {
            transactions = try await dataManager.fetchTransactions(for: passId)
            cacheSize = await dataManager.cacheSize
        } catch {
            print("Error loading transactions: \(error)")
        }
    }
    
    func loadAllTransactionsConcurrently() async {
        isLoading = true
        selectedPassId = "all"
        defer { isLoading = false }
        
        do {
            transactions = try await dataManager.fetchAllTransactionsConcurrently(
                for: passes.map { $0.id }
            )
            cacheSize = await dataManager.cacheSize
        } catch {
            print("Error loading all transactions: \(error)")
        }
    }
}
