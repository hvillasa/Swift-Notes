import Foundation

/*

 https://www.geeksforgeeks.org/minimum-number-swaps-required-sort-array/
 
 
 Given an array of n distinct elements,
 find the minimum number of swaps required to sort the array.
 
 */

func minimumSwaps(arr: [Int]) -> Int {
    var swapCount = 0
    var arrayPositionValue = [(Int, Int)]()
    var visitedDictionary = [Int: Bool]()
    
    for (index, number) in arr.enumerated() {
        arrayPositionValue.append((index, number))
        visitedDictionary[index] = false
    }
    
    arrayPositionValue = arrayPositionValue.sorted{ $0.1 < $1.1 }

    for i in 0..<arr.count {
        var cycleSize = 0
        var visitedIndex = i

        while !visitedDictionary[visitedIndex]! {
            visitedDictionary[visitedIndex] = true
            visitedIndex = arrayPositionValue[visitedIndex].0
            cycleSize += 1
        }

        if cycleSize > 0 {
            swapCount += cycleSize - 1
        }
    }

    return swapCount
}

let arr1 = [5,2,4,1,3]

print(arr1)
let swapCount = minimumSwaps(arr: arr1) // -> 3
print("swap count: ", swapCount)

