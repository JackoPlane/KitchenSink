//
//  Dish.swift
//
//  Copyright (c) 2023 Jack Perry <github@jckpry.me>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import os.log
import Foundation

/// The data being operated on by each operation.

public struct Dish {

    // MARK: - Properties

    private let logger: Logger
    private let signposter: OSSignposter

    private let accessLock = UnfairLock()
    private var value: Data?

    // MARK: - Initialisation

    public init(value: Data? = nil) {
        self.init(value: value, signposter: nil)
    }

    internal init(value: Data?, logger: Logger = .default, signposter: OSSignposter? = nil) {
        self.value = value
        self.logger = logger
        self.signposter = signposter ?? OSSignposter(logger: logger)
    }

    // MARK: - Getters / Setters

    public func get() -> Data? {
        accessLock.withLock {
            self.value
        }
    }

    public mutating func set(_ value: Data) {
        signposter.emitEvent("SetDishValue", "value=\(value)")
        accessLock.withLock {
            self.value = value
        }
    }

    // MARK: - Cloning

    internal func clone() -> Dish {
        Dish(value: self.value)
    }

}
