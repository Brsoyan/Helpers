//
//  MemoryAllocate.swift
//  Helper
//
//  Created by Hayk Brsoyan on 11/5/20.
//

import Foundation

final class Helper {
    static let shared = Helper()
    
    func performMemoryWarning(delay: Double, shouldRepeat: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            if UIApplication.shared.responds(to: Selector("_performMemoryWarning")) {
                UIApplication.shared.performSelector(onMainThread: Selector("_performMemoryWarning"), with: nil, waitUntilDone: false)
            } else {
                print("Whoops UIApplication no loger responds to -_performMemoryWarning")
            }

            if shouldRepeat {
                self.performMemoryWarning(delay: delay, shouldRepeat: shouldRepeat)
            }
        }
    }
}

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
