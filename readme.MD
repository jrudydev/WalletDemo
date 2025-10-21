# iOS Wallet Demo App

A demonstration iOS application showcasing advanced iOS development concepts including concurrency, memory management, and algorithmic thinking.

Built as interview preparation for iOS engineering positions.

## 🎯 Purpose

This project demonstrates proficiency in:

- **Concurrency & Multi-threading**
  - Grand Central Dispatch (GCD)
  - Modern Swift Concurrency (async/await, actors)
  - Task Groups for concurrent operations
  - Thread-safe data structures

- **Memory Management**
  - Automatic Reference Counting (ARC)
  - Actor-based thread safety
  - LRU Cache with O(1) operations
  - Proper weak/unowned reference usage
  - Value types vs Reference types

- **Common Algorithms & Data Structures**
  - Binary Search (O(log n))
  - Quick Sort & Merge Sort (O(n log n))
  - LRU Cache (doubly-linked list + hash map)
  - Two Pointer technique
  - Sliding Window algorithm
  - Hash-based lookups and filtering

## 🏗️ Architecture

### Components

- **Models**: `Pass`, `Transaction` - Value types for data integrity
- **DataManager**: `@MainActor` class handling async operations
- **LRUCache**: Thread-safe actor with O(1) get/put operations
- **AlgorithmUtils**: Implementations of common CS algorithms
- **TransactionProcessor**: Sorting, filtering, and aggregation logic

### Concurrency Patterns

```swift
// Actor for thread safety
actor LRUCache<Key: Hashable, Value> {
    // Automatically thread-safe
}

// Task Groups for concurrent fetching
try await withThrowingTaskGroup(of: [Transaction].self) { group in
    for passId in passIds {
        group.addTask {
            try await fetchTransactions(for: passId)
        }
    }
}

// @MainActor for UI updates
@MainActor
class DataManager: ObservableObject {
    @Published var passes: [Pass] = []
}
```

### Memory Management

- Actor-based synchronization prevents data races
- Weak delegate references prevent retain cycles
- Value types (structs) for models avoid reference counting overhead
- Bounded LRU cache prevents unbounded memory growth

## 🚀 Features

- **Pass Management**: Display and manage multiple wallet passes
- **Transaction History**: View and filter transaction records
- **Concurrent Data Loading**: Fetch multiple resources simultaneously
- **Smart Caching**: Multi-layer caching with LRU eviction
- **Search & Filter**: Real-time search with multiple sort options
- **Statistics**: Aggregate transaction data with category analysis

## 📊 Performance Characteristics

| Operation | Time Complexity | Space Complexity |
|-----------|----------------|------------------|
| Cache Get | O(1) | O(capacity) |
| Cache Put | O(1) | O(capacity) |
| Binary Search | O(log n) | O(1) |
| Quick Sort | O(n log n) avg | O(log n) |
| Transaction Filter | O(n) | O(n) |
| Stats Calculation | O(n) | O(categories) |

## 🛠️ Technical Stack

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Concurrency**: Swift Concurrency (async/await, actors)
- **Architecture**: MVVM with reactive bindings
- **Minimum iOS**: 16.0+

## 📱 Screenshots

[Add screenshots here when you have them]

## 🏃 Running the Project

1. Clone the repository:
```bash
git clone https://github.com/yourusername/wallet-demo.git
cd wallet-demo
```

2. Open in Xcode:
```bash
open WalletDemo.xcodeproj
```

3. Build and run (⌘R) on iOS Simulator or device

**Requirements:**
- Xcode 15.0+
- iOS 16.0+ deployment target
- macOS 13.0+ (for development)

## 🧪 Testing Approach

The app includes comprehensive demonstrations of:

- Thread-safe concurrent operations
- Memory management best practices
- Algorithm implementations with known complexity
- Cache behavior monitoring (check console logs)

### What to Look For

- Console logs showing cache hits/misses
- Concurrent fetch operations completing simultaneously
- Proper deallocation (no memory leaks)
- Smooth UI performance during data operations

## 📚 Learning Resources

This project implements concepts from:

- [Apple's Concurrency Documentation](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
- [Swift Evolution Proposals](https://github.com/apple/swift-evolution)
- Classic algorithms and data structures

## 🤝 Contributing

This is a demonstration project for educational purposes. While it's not actively maintained for production use, feedback and suggestions are welcome!

## 📄 License

MIT License

Copyright (c) 2025 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## 👤 About

Created by Rudy Gomez as interview preparation for iOS engineering positions.

Built with ❤️  and Swift

---

**Note**: This is a demonstration project showcasing iOS development skills. It uses simulated data and is not intended for production use with real financial information.

## 🔗 Connect

- GitHub: jrudydev(https://github.com/jrudydev)
- LinkedIn: jrududygomez(https://linkedin.com/in/jrudygomez)
- Portfolio: jrudygomez(https://jrudygomez.com)

## ⭐ Acknowledgments

- Built as preparation for technical interviews
- Inspired by Apple Wallet's elegant design
- Demonstrates production-ready iOS development patterns
