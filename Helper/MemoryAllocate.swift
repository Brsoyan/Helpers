//
//  MemoryAllocate.swift
//  Helper
//
//  Created by Hayk Brsoyan on 11/5/20.
//

import Foundation

@objcMembers class MemoryAllocate: NSObject {
    static let shared = MemoryAllocate()
    private var buffer: [UInt8]?
    private override init() {
        super.init()
        if buffer == nil {
            allocateMemoryOfSize(numberOfBytes: 1600000000) // 1000000 ~> 1MB
        }
    }
    private func allocateMemoryOfSize(numberOfBytes: Int) {
        DispatchQueue.global().async {
            self.buffer = [UInt8](repeating: 0, count: numberOfBytes)
            for i in 0 ..< numberOfBytes {
                self.buffer![i] = UInt8(i % 7)
            }
        }
   }
}
