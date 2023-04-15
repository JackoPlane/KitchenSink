//
//  Recipe.swift
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

/// The `Recipe` controls a list of `Operation`s and the `Dish` they operate on.
public final class Recipe {

    // MARK: - Errors

    public enum Error: Swift.Error {
        case invalidStartIndex
    }


    // MARK: - Properties

    private let logger: Logger

    /// Array of `Operation`
    public private(set) var operations: [Operation<Any, Any>]

    private var lastExecuted: Operation<Any, Any>? = nil

    // MARK: - Initialisation

    /// Initialise a new `Recipe` with an array of operations
    /// - Parameter operations: Array of initial operations
    public init(_ operations: [Operation<Any, Any>], logger: Logger? = nil) {
        self.operations = operations
        self.logger = logger ?? .recipeLogger
    }

    // MARK: - Operations

    /// Adds a new `Operation` to this `Recipe`.
    /// - Parameter operation: The operation
    public func addOperation(_ operation: Operation<Any, Any>) {
        self.operations.append(operation)
    }

    /// Adds a new Operation to this Recipe.
    /// - Parameter operations: Operations
    public func addOperations(_ operations: [Operation<Any, Any>]) {
        self.operations.append(contentsOf: operations)
    }

    // MARK: - Breakpoints

    /// Set a breakpoint on a specified `Operation`.
    /// - Parameters:
    ///   - index: The index of the `Operation`
    ///   - enabled: Should the breakpoint be enabled
    public func setBreakpoint(_ index: Int, enabled: Bool) {
        guard let operation = self.operations[optional: index] else { return }
        operation.breakpoint = enabled
    }

    /// Remove breakpoints on all `Operation` in the `Recipe` up to the specified position. Used by Flow
    /// Control Fork operation.
    ///
    /// - Parameter index: position
    public func removeBreakpoints(upTo index: Int) {
        self.operations.prefix(index).forEach {
            $0.breakpoint = false
        }
    }

    // MARK: - Execution

    /// Executes each operation in the recipe over the given `Dish`.
    /// - Parameters:
    ///   - dish: The dish to operate upon
    ///   - startFrom: The index of the `Operation` to start executing from
    /// - Returns: The final progress through the `Recipe`.
    public func execute(dish: Any, startFrom: Int = 0) async throws -> Int {
        guard startFrom < operations.count else {
            throw Error.invalidStartIndex
        }

        if startFrom == 0 {
            self.lastExecuted = nil
        }

        logger.debug("[*] Executing recipe of \(self.operations.count) operations, starting at index \(startFrom).")

        for (index, operation) in self.operations.dropFirst(startFrom).enumerated() {
            logger.debug("[\(index)] \(operation.name)")

            // Skip if disabled
            guard operation.disabled == false else {
                logger.debug("Operation is disabled, skipping..")
                continue
            }

            // Return this index if the operation is breakpointed
            guard operation.breakpoint == false else {
                logger.debug("Pausing at breakpoint")
                return index
            }

            // TODO: Execute the operation
        }

        logger.debug("Recipe complete")
        return operations.count
    }

}

private extension Logger {

    static let recipeLogger = Logger(subsystem: "com.JackoPlane.kitchen-sink", category: "recipe")

}
