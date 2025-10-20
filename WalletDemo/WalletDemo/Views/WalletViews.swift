//
//  WalletViews.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import SwiftUI

struct WalletView: View {
    @StateObject private var viewModel = WalletViewModel()
    @State private var showStats = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    CacheSizeBadge(size: viewModel.cacheSize)
                    
                    PassListSection(
                        passes: viewModel.passes,
                        onPassTap: { pass in
                            Task {
                                await viewModel.loadTransactions(for: pass.id)
                            }
                        },
                        onLoadAll: {
                            Task {
                                await viewModel.loadAllTransactionsConcurrently()
                            }
                        }
                    )
                    
                    if !viewModel.transactions.isEmpty {
                        TransactionListSection(
                            transactions: viewModel.filteredTransactions,
                            stats: viewModel.stats,
                            showStats: $showStats,
                            searchText: $viewModel.searchText,
                            sortOption: $viewModel.sortOption,
                            selectedPassId: viewModel.selectedPassId
                        )
                    }
                    
                    ImplementationNotesView()
                        .padding()
                }
                .padding(.vertical)
            }
            .navigationTitle("Wallet Demo")
            .navigationBarTitleDisplayMode(.large)
            .task {
                await viewModel.loadPasses()
            }
            .overlay {
                if viewModel.isLoading {
                    LoadingView()
                }
            }
        }
    }
}

// MARK: - Cache Size Badge

struct CacheSizeBadge: View {
    let size: Int

    var body: some View {
        HStack {
            Image(systemName: "shippingbox.fill")
                .foregroundColor(.blue)
            Text("Cache Size: \(size)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
    }
}

// MARK: - Pass List Section

struct PassListSection: View {
    let passes: [Pass]
    let onPassTap: (Pass) -> Void
    let onLoadAll: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Passes")
                    .font(.headline)
                Spacer()
                Button(action: onLoadAll) {
                    Label("Load All", systemImage: "arrow.down.circle.fill")
                        .font(.caption)
                }
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(passes) { pass in
                        PassCard(pass: pass)
                            .onTapGesture {
                                onPassTap(pass)
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Transaction List Section

struct TransactionListSection: View {
    let transactions: [Transaction]
    let stats: TransactionStats
    @Binding var showStats: Bool
    @Binding var searchText: String
    @Binding var sortOption: TransactionProcessor.SortOption
    let selectedPassId: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Transactions")
                    .font(.headline)
                if let passId = selectedPassId {
                    Text(passId == "all" ? "All Passes" : passId)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(6)
                }
                Spacer()
                Button(action: { showStats.toggle() }) {
                    Image(systemName: showStats ? "chart.bar.fill" : "chart.bar")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)

            if showStats {
                StatsView(stats: stats)
                    .padding(.horizontal)
            }

            VStack(spacing: 8) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    TextField("Search transactions...", text: $searchText)
                        .textFieldStyle(.plain)
                }
                .padding(8)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)

                Picker("Sort By", selection: $sortOption) {
                    Text("Date").tag(TransactionProcessor.SortOption.date)
                    Text("Amount").tag(TransactionProcessor.SortOption.amount)
                    Text("Merchant").tag(TransactionProcessor.SortOption.merchant)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }

            VStack(spacing: 1) {
                ForEach(transactions) { transaction in
                    TransactionRow(transaction: transaction)
                }
            }
            .background(Color.secondary.opacity(0.05))
            .cornerRadius(12)
            .padding(.horizontal)
        }
    }
}
