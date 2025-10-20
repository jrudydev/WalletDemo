//
//  AlgorithmUtils.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import Foundation

enum AlgorithmUtils {
    // MARK: - Binary Search
    
    static func binarySearch<T: Comparable>(in array: [T], target: T) -> Int? {
        var left = 0
        var right = array.count - 1
        
        while left <= right {
            let mid = left + (right - left) / 2
            
            if array[mid] == target {
                return mid
            } else if array[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        
        return nil
    }
    
    // MARK: - Quick Sort
    
    static func quickSort<T: Comparable>(_ array: [T]) -> [T] {
        guard array.count > 1 else { return array }
        
        let pivot = array[array.count / 2]
        let less = array.filter { $0 < pivot }
        let equal = array.filter { $0 == pivot }
        let greater = array.filter { $0 > pivot }
        
        return quickSort(less) + equal + quickSort(greater)
    }
    
    // MARK: - Merge Sort
    
    static func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
        guard array.count > 1 else { return array }
        
        let middleIndex = array.count / 2
        let leftArray = mergeSort(Array(array[0..<middleIndex]))
        let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
        
        return merge(leftArray, rightArray)
    }
    
    private static func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
        var leftIndex = 0
        var rightIndex = 0
        var result: [T] = []
        
        while leftIndex < left.count && rightIndex < right.count {
            if left[leftIndex] < right[rightIndex] {
                result.append(left[leftIndex])
                leftIndex += 1
            } else {
                result.append(right[rightIndex])
                rightIndex += 1
            }
        }
        
        result.append(contentsOf: left[leftIndex...])
        result.append(contentsOf: right[rightIndex...])
        
        return result
    }
    
    // MARK: - Two Sum
    
    static func twoSum(_ numbers: [Int], target: Int) -> (Int, Int)? {
        var left = 0
        var right = numbers.count - 1
        
        while left < right {
            let sum = numbers[left] + numbers[right]
            if sum == target {
                return (left, right)
            } else if sum < target {
                left += 1
            } else {
                right -= 1
            }
        }
        
        return nil
    }
    
    // MARK: - Sliding Window
    
    static func maxSumSubarray(_ array: [Int], k: Int) -> Int? {
        guard array.count >= k else { return nil }
        
        var windowSum = array[0..<k].reduce(0, +)
        var maxSum = windowSum
        
        for i in k..<array.count {
            windowSum = windowSum - array[i - k] + array[i]
            maxSum = max(maxSum, windowSum)
        }
        
        return maxSum
    }
}
