//
//  DataManager.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import Foundation

actor DataManager {
    private let cache: LRUCache<String, Data>
    private let networkService: NetworkService
    
    init(
        cacheCapacity: Int = 20,
        networkService: NetworkService = NetworkService()
    ) {
        self.cache = LRUCache(capacity: cacheCapacity)
        self.networkService = networkService
    }
    
    var cacheSize: Int {
        get async {
            await cache.count
        }
    }
    
    func fetchPasses() async throws -> [Pass] {
        let cacheKey = CacheKeys.allPasses
        
        if let cached: [Pass] = try? await getCached(key: cacheKey) {
            print("✓ Cache hit: passes")
            return cached
        }
        
        print("⊗ Cache miss: fetching passes...")
        try await Task.sleep(nanoseconds: 800_000_000)
        
        let passes = MockDataGenerator.generatePasses()
        try await cache(passes, forKey: cacheKey)
        
        return passes
    }
    
    func fetchTransactions(for passId: String) async throws -> [Transaction] {
        let cacheKey = CacheKeys.transactions(passId)
        
        if let cached: [Transaction] = try? await getCached(key: cacheKey) {
            print("✓ Cache hit: transactions for \(passId)")
            return cached
        }
        
        print("⊗ Cache miss: fetching transactions for \(passId)...")
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let allTransactions = MockDataGenerator.generateTransactions()
        let filtered = allTransactions.filter { $0.passId == passId }
        try await cache(filtered, forKey: cacheKey)
        
        return filtered
    }
    
    func fetchAllTransactionsConcurrently(for passIds: [String]) async throws -> [Transaction] {
        print("🚀 Starting concurrent fetch...")
        
        return try await withThrowingTaskGroup(of: [Transaction].self) { group in
            for passId in passIds {
                group.addTask {
                    try await self.fetchTransactions(for: passId)
                }
            }
            
            var results: [Transaction] = []
            for try await transactions in group {
                results.append(contentsOf: transactions)
            }
            return results
        }
    }
    
    // MARK: - Private Helpers
    
    private func getCached<T: Codable>(key: String) async throws -> T? {
        guard let data = await cache.get(key) else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func cache<T: Codable>(_ object: T, forKey key: String) async throws {
        let data = try JSONEncoder().encode(object)
        await cache.put(key, value: data)
    }
}

// MARK: - Cache Keys

private enum CacheKeys {
    static let allPasses = "all_passes"
    
    static func transactions(_ passId: String) -> String {
        "transactions_\(passId)"
    }
}
