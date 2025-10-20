//
//  LRUCache.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import Foundation

actor LRUCache<Key: Hashable, Value> {
    private var cache: [Key: Node] = [:]
    private var head: Node?
    private var tail: Node?
    private let capacity: Int
    
    class Node {
        let key: Key
        var value: Value
        var prev: Node?
        var next: Node?
        
        init(key: Key, value: Value) {
            self.key = key
            self.value = value
        }
    }
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Key) -> Value? {
        guard let node = cache[key] else { return nil }
        moveToHead(node)
        return node.value
    }
    
    func put(_ key: Key, value: Value) {
        if let existingNode = cache[key] {
            existingNode.value = value
            moveToHead(existingNode)
        } else {
            let newNode = Node(key: key, value: value)
            cache[key] = newNode
            addToHead(newNode)
            
            if cache.count > capacity {
                if let tailNode = tail {
                    removeNode(tailNode)
                    cache.removeValue(forKey: tailNode.key)
                }
            }
        }
    }
    
    func clear() {
        cache.removeAll()
        head = nil
        tail = nil
    }
    
    var count: Int {
        cache.count
    }
    
    // MARK: - Private Methods
    
    private func moveToHead(_ node: Node) {
        removeNode(node)
        addToHead(node)
    }
    
    private func addToHead(_ node: Node) {
        node.next = head
        node.prev = nil
        
        if let head = head {
            head.prev = node
        }
        
        head = node
        
        if tail == nil {
            tail = node
        }
    }
    
    private func removeNode(_ node: Node) {
        if let prev = node.prev {
            prev.next = node.next
        } else {
            head = node.next
        }
        
        if let next = node.next {
            next.prev = node.prev
        } else {
            tail = node.prev
        }
    }
}
