//
//  Mutex.swift
//  MovieStreamTime
//
//  Created by yilmaz on 9.04.2023.
//

import Foundation

class Mutex {
    private let lock = NSLock()

    func sync<T>(_ closure: () -> T) -> T {
        lock.lock()
        defer { lock.unlock() }
        return closure()
    }
}
